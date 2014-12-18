class CreateEsaTypes < ActiveRecord::Migration
  def change
    create_table :esa_types do |t|
      t.string :name
      t.integer :esa_id
      t.timestamps
    end
  end
end
