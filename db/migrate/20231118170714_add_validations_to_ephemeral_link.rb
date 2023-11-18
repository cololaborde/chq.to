class AddValidationsToEphemeralLink < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ephemeral_links, :used, false
  end
end
