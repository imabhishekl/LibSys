class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, {id: false} do |t|
      t.string "user_name",  :limit => 25  , :null => false  ,:unique => true
      t.string "name",      :limit => 25   , :null => false
      t.string "password",  :limit => 50   , :null => false
      t.string "email_id",  :limit => 25   , :null => false
      t.string "status",    :limit => 10   , :null => false, :default => "Active"
      t.timestamps null: false
    end
    execute %Q(ALTER TABLE users ADD PRIMARY KEY (user_name);)
  end

  def down
    drop_table:users
  end
end
