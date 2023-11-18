class CreateEphemeralLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :ephemeral_links do |t|
      t.boolean :used
      t.references :regular_link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
