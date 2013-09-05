class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms, :id => false do |t|
      t.string :name
      t.integer :rid
      t.integer :rid_parent

      t.timestamps
    end
  end
end
