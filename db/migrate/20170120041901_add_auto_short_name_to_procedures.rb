class AddAutoShortNameToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :auto_short_name, :string
  end
end
