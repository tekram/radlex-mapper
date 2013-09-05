class CreateProceduresTermsTable < ActiveRecord::Migration
  def change
    create_table :procedures_terms, :id => false do |t|
      t.integer :procedure_id
      t.integer :term_id
    end
  end

end
