class AddPetitionLinkToEsas < ActiveRecord::Migration
  def change
    add_column :esas, :petition_link, :string
  end
end
