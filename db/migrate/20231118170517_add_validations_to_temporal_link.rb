class AddValidationsToTemporalLink < ActiveRecord::Migration[7.1]
  def change
    change_column_null :temporal_links, :expiration_date, false
  end
end
