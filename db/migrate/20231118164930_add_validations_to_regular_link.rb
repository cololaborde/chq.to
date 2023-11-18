class AddValidationsToRegularLink < ActiveRecord::Migration[7.1]
  def change
    change_column_null :regular_links, :slug, false
    change_column_null :regular_links, :destination_url, false
  end
end
