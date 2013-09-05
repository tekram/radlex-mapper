require 'csv'
class Procedure < ActiveRecord::Base
	set_primary_key "rpid"
	
	attr_accessible :rpid, :short_name, :long_name, :description
	
	has_and_belongs_to_many :terms
	
	def self.import()
		CSV.foreach("playbook.csv") do |row|
			#puts row[0]
			#Term.create(
			rpid = row[0].sub("RPID","") if row[0] != nil
			rids = row[4].sub("RID","") if row[4] != nil
			rids = rids.split("|")
			procedure = Procedure.create(:rpid => rpid, :short_name => row[1],
				:long_name => row[2], :description => row[3])
			rids.each {|rid|
				procedure.terms << Term.find(rid)
			}	
			puts row[0]
			#rid_parent = row[2].sub("RID","") if row[2] != nil
			#Term.create(:name => row[0], :rid => rid, :rid_parent => rid_parent)
		end 
	end

	

end
