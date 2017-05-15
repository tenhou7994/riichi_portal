class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :login
      t.string   :email
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :password_token
      t.integer  :furiten_id
      t.string   :first_name
      t.string   :last_name
      t.string   :tenhou_ident
      t.string   :persistence_token
      t.integer  :login_count, default: 0,  null: false
      t.integer  :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_ip
      t.timestamps
    end
  end
end
