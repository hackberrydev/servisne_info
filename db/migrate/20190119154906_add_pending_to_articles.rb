class AddPendingToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :pending, :boolean, default: true, null: false
  end
end
