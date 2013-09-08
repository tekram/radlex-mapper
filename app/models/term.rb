require 'csv'
class Term < ActiveRecord::Base

	attr_accessible :rid, :name, :rid_parent
	set_primary_key "rid"
	has_many :children, :class_name => "Term", :foreign_key => "rid_parent"
  belongs_to :parent, :class_name => "Term", :foreign_key => "rid_parent"
  has_and_belongs_to_many :procedures
  
  def self.findRadlex(terms)
		res = Array.new
		count = 0
		radlex_terms = Array.new
		terms.each{|term|
			radlex_term = Array.new
			radlex_terms = Term.where("name LIKE ?", "%#{term}%")
			radlex_terms_w_procedures = Array.new
			radlex_terms.each{|rterm|
				if !rterm.procedures.empty?
					radlex_terms_w_procedures << rterm
				end
			}
			res[count] = radlex_terms_w_procedures
			count = count + 1
		}
		return res
  end
  
  def self.substituteTerms(terms)
		count = 0
		terms.each{|term|
			subterm = Abreviation.find_by_abreviated_name(term)
			if subterm
				terms[count] = subterm.name
			end
			count = count + 1
		}
		return terms
  end
  
	def self.import
		CSV.foreach("Radlex3.9.csv") do |row|
			#Term.create(
			#puts row
			rid = row[1].sub("RID","") if row[1] != nil
			rid_parent = row[2].sub("RID","") if row[2] != nil
			Term.create(:name => row[0], :rid => rid, :rid_parent => rid_parent)
		end 
	end

end
