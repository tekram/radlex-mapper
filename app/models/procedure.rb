require 'csv'
class Procedure < ActiveRecord::Base
	set_primary_key "rpid"
	
	attr_accessible :rpid, :short_name, :long_name, :description
	
	has_and_belongs_to_many :terms
	
	#checks to see which 
	def self.pbm
				CSV.foreach("mrsheet.csv") do |row|
					length = row.length
					
				end
	end
	
	def self.exclusiveMatch(radlexmatches,intersection)
		#radlexmatches = [1,2]
		#intersection 
		puts radlexmatches.length
		puts intersection
		length = radlexmatches.length + 1
		excl = nil
		intersection.each{|proc|
			if proc.terms.length == length
				excl = proc
				#break
			end
		}
		return excl
	end
	
	def self.findIntersection(array)
		count = 1
		#array = array.flatten
		res = array[0].procedures
		array.each {|ele|
			res = ele.procedures & res
		}
		return res
	end
	
	def self.bestMatch(array)
		res = nil
		length = 999999
		array.each{|proc|
			if proc.terms.length < length
				length = proc.terms.length
				res = proc
			end
		}
		return res
	end
	
	def self.import
		CSV.foreach("playbook.csv") do |row|
			#puts row[0]
			#Term.create(
			rpid = row[0].sub("RPID","") if row[0] != nil
			rids = row[4].gsub("RID","") if row[4] != nil
			rids = rids.sub("|0","")
			rids = rids.split("|")
			procedure = Procedure.create(:rpid => rpid, :short_name => row[1],
				:long_name => row[2], :description => row[3])
			rids.each {|rid|
				procedure.terms << Term.find(rid) if Term.exists?(rid)
			}	
			puts row[0]
			#break
			#rid_parent = row[2].sub("RID","") if row[2] != nil
			#Term.create(:name => row[0], :rid => rid, :rid_parent => rid_parent)
		end 
	end

	

end
