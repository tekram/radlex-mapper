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
			radlex_terms.each{|rterm|
				if rterm.procedures.empty?
					radlex_terms.delete(rterm)
				end
			}
			res[count] = radlex_terms
			count = count + 1
		}
		return res
  end
  
	def self.import
		CSV.foreach("Radlex3.9.csv") do |row|
			#Term.create(
			rid = row[1].sub("RID","") if row[1] != nil
			rid_parent = row[2].sub("RID","") if row[2] != nil
			Term.create(:name => row[0], :rid => rid, :rid_parent => rid_parent)
		end 
	end

	def self.setParentId
		Term.all.each { |term|
			if term.rid_parent != nil
				puts term.name
				parent = Term.find_by_rid(term.rid_parent)
				if parent != nil
					term.parent_id = parent.id
					term.save
				end
			#else 
			#	puts "Nope"
			end
		}
	end

end
