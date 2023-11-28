# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at

      t.string :user_name, null: false, default: ""
      t.string :name, null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :user_name,            unique: true
  end
end
