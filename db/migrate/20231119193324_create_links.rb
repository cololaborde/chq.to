class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :slug, null: false, index: { unique: true }
      t.string :destination_url, null: false
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.datetime :expiration_date
      t.string :password
      t.boolean :used
      t.timestamps
    end
  end
end
