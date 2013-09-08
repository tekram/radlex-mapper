class CreateAbreviations < ActiveRecord::Migration
  def change
    create_table :abreviations do |t|
      t.string :name
      t.string :abreviated_name
      t.integer :rid

      t.timestamps
    end
  end
end
