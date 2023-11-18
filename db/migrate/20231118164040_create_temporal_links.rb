class CreateTemporalLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :temporal_links do |t|
      t.datetime :expiration_date
      t.references :regular_link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
