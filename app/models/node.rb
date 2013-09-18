require 'csv'

class Node < ActiveRecord::Base
	has_many :terms, :through => :edges
	has_many :edges, :order => "weight DESC"

	def strongest
		edges = self.edges[0]
	end

	def self.import#Mappings
		CSV.foreach("nmmappings.csv") do |row|
				puts row[0]
				strings = row[1].downcase.gsub("with","").gsub("without","").gsub("and","").gsub("contrast","").split(" ")
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
