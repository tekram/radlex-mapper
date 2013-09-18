class CreateEdges < ActiveRecord::Migration
  def change
    create_table :edges do |t|
      t.integer :term_id
      t.integer :node_id
      t.integer :weight

      t.timestamps
    end
  end
end
