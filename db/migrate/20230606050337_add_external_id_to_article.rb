class AddExternalIdToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :external_id, :string
  end
end
