class RemovePhonesFromContacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :phones, :string
  end
end
