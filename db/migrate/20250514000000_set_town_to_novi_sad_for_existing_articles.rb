class SetTownToNoviSadForExistingArticles < ActiveRecord::Migration[7.2]
  def up
    execute "UPDATE articles SET town = 'novi sad'"
  end

  def down
    execute "UPDATE articles SET town = NULL"
  end
end
