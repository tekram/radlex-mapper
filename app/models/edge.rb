class Edge < ActiveRecord::Base
	belongs_to :term
	belongs_to :node

end
