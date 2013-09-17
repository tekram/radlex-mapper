require 'csv'
class Term < ActiveRecord::Base

	attr_accessible :rid, :name, :rid_parent
	set_primary_key "rid"
	has_many :children, :class_name => "Term", :foreign_key => "rid_parent"
  belongs_to :parent, :class_name => "Term", :foreign_key => "rid_parent"
  has_and_belongs_to_many :procedures
  
  # goes through an array of terms and maps them to RadLex Terms
  def self.findRadlex(terms)
		res = Array.new
		#count = 0
		radlex_terms = Array.new
		terms = Term.removeRedundancy(terms)
		terms.each{|term|

			high = 0
			highestterm = nil
			if !Conjunction.find_by_name(term).nil?
				next
			end
			#first check to see if the term exists exaclty as present in the query
			radlex_terms = Term.where("name LIKE ?", term)
			#then do a more wild card check for it
			radlex_terms = Term.where("name LIKE ?", "%#{term}%") if radlex_terms.empty? or radlex_terms[0].procedures.empty?
			if radlex_terms.empty? and (term.index("gram") or term.index("graphy"))
				if term.index("gram")
					term = term.gsub("gram","graphy")
				else
					term = term.gsub("graphy", "gram")
				end
				radlex_terms = Term.where("name LIKE ?", "%#{term}%")
			end
			radlex_terms.each{|rterm|
				if !rterm.procedures.empty? and rterm.procedures.length > high
					highestterm = rterm
					high = rterm.procedures.length
				end
			}
			res << highestterm if highestterm

		}
		return res
  end
  
  # Substitutes abdomen for abd
  def self.substituteTerms(terms)
		count = 0
		terms.each{|term|
			# hack for now to account when one abreviated term applies to more than on RadLex term
			if term == "mra" or term == "cta"
				term = term[0..1]
				terms << "angiography"
			end
			subterm = Abreviation.find_by_abreviated_name(term)
			if subterm
				terms[count] = subterm.name
			end
			count = count + 1
		}
		return terms
  end
  
  def self.contrastCheck(string, array)
		if string.index("with contrast")
			array.delete("with")
			array.delete("contrast")
			array << "with iv contrast"
		elsif string.index("with and without contrast")	
			array.delete("with")
			array.delete("without")
			array.delete("contrast")
			array << "without then with iv contrast"
		end
		
		return array
  end
  
  def self.checkTwo(array)
		position = 0
		length = array.length
		result = Array.new
		while position + 1 < length
			query = array[position] + " " + array[position + 1]
			radlex_terms = Term.where("name LIKE ?", "%#{query}%")
			if radlex_terms.empty?
				result << array[position]
			else
				high = 0
				highestterm = nil
				radlex_terms.each{|rterm|
					if !rterm.procedures.empty? and rterm.procedures.length > high
						highestterm = rterm
						high = rterm.procedures.length
					end
				}
				if highestterm != nil
					result << array[position] + " " + array[position + 1]
					position = position + 1
				else
					result << array[position]
				end
			end
			position = position + 1
			if position + 1 == length
				result << array[position]
			end
		end
		return result
  end
  
  def self.removeRedundancy(array)
		if array.index("unilateral") and (array.index("right") or array.index("left"))
			return array - ["unilateral"]
		else
			return array
		end
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
