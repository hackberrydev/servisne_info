class AddIndexOnUrlToArticles < ActiveRecord::Migration[7.0]
  def change
    add_index :articles, :url, unique: true
  end
end
