require 'csv'

class Node < ActiveRecord::Base
	has_many :terms, :through => :edges
	has_many :edges, :order => "weight DESC"

	def strongest
		edges = self.edges[0].term
	end

	#uses the Playbook itself to learn 
	def self.importpb
		#Node.delete_all
		#Edge.delete_all
		Procedure.all.each{|proc|
			strings = proc.long_name.downcase.gsub("&","").split(" ")
			puts proc.rpid 
			puts proc.short_name.downcase.gsub("&","")
			strings.each{|string|
				node = Node.find_or_create_by_name(string)
				#puts node.name
				proc.terms.each{|radlex|
					if radlex.id == 13060
						next
					end
					#puts "radlex"
					#puts radlex.name
					edges = node.edges.where(:term_id => radlex.id)
					#puts "edges"
					if edges.empty?
						node.edges << Edge.create(:term_id => radlex.id, :weight => 0)
					else
						#puts "edge"
						edge = edges[0]
						edge.weight = edge.weight + 1
						edge.save
					end
				}
			}
		}
	end

	#used to import existing mappings; first column is the RPID and the second column is the name
	def self.import#Mappings
		CSV.foreach("navalxr.csv") do |row|
				puts row[0]
				rawstring = row[1]
				contrast = String.new
				if rawstring.index("with")
					contrast = rawstring[rawstring.index("with")..rawstring.length]
				#elsif string.index("without")
				#	contrast = string[string.index("without")..string.lenght]
				end
				strings = row[1].downcase.gsub("with","").gsub("without","").gsub("and","").gsub("contrast","").split(" ")
				strings << contrast if !contrast.empty?
				proc = Procedure.find(row[0].gsub("RPID","")) if Procedure.exists?(row[0].gsub("RPID",""))
				if proc == nil 
					#gets
					next
				else
					radlex_terms = proc.terms
					strings.each{|q|
						node = Node.find_or_create_by_name(q)
						radlex_terms.each{|radlex|
							if radlex.id == 13060
								next
							end
							edges = node.edges.where(:term_id => radlex.id)
							if edges.empty?
								node.edges << Edge.create(:term_id => radlex.id, :weight => 0)
							else
								edge = edges[0]
								edge.weight = edge.weight + 1
								edge.save
							end
						}
					}
				end
		end
	end

end
