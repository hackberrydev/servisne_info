class ChangeUniqueIndexOnArticleUrlToBeScopedToTown < ActiveRecord::Migration[7.2]
  def change
    remove_index :articles, :url
    add_index :articles, [:url, :town], unique: true
  end
end
