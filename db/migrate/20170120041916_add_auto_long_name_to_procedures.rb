class AddAutoLongNameToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :auto_long_name, :string
  end
end
