class CreateEsas < ActiveRecord::Migration
  def change
    create_table :esas do |t|
      t.string :title
      t.text :message
      t.text :first_section_msj
      t.text :second_section_msj

      t.timestamps
    end
  end
end
