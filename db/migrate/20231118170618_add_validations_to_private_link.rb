class AddValidationsToPrivateLink < ActiveRecord::Migration[7.1]
  def change
    change_column_null :private_links, :password, false
  end
end
