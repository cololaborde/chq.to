class CreatePrivateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :private_links do |t|
      t.string :password
      t.references :regular_link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
