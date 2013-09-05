class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures, :id => false do |t|
      t.integer :rpid
      t.string :short_name
      t.string :long_name
      t.text :description

      t.timestamps
    end
  end
end
