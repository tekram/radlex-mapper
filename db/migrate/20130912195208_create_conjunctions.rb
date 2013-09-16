class CreateConjunctions < ActiveRecord::Migration
  def change
    create_table :conjunctions do |t|
      t.string :name

      t.timestamps
    end
  end
end
