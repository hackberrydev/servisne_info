class AddStreetsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :streets, :string
  end
end
