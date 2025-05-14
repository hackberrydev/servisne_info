class AddTownToArticle < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :town, :string
  end
end
