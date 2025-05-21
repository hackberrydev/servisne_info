class AddTownsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :towns, :string, array: true, default: []
  end
end
