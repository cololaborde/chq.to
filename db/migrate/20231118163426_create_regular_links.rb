class CreateRegularLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :regular_links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :slug
      t.string :name
      t.string :destination_url

      t.timestamps
    end
    add_index :regular_links, :slug
  end
end
