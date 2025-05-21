class InitializeTownsForExistingUsers < ActiveRecord::Migration[7.2]
  def up
    execute "UPDATE users SET towns = ARRAY['novi sad'] WHERE towns = '{}' OR towns IS NULL"
  end

  def down
    execute "UPDATE users SET towns = NULL"
  end
end
