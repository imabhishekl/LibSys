class CreateAdmins < ActiveRecord::Migration
  def up
    create_table :admins,id:false do |t|
      t.string :user_name,:limit => 25, :null => false
      t.string :name, :limit => 25, :null => false
      t.string :password, :limit => 50, :null => false
      t.string :email, :limit => 25, :null => false 
      t.string :primary_ind,:limit => 1, :null => false
      t.timestamps null: false
    end
      execute <<-SQL
        ALTER TABLE admins
        ADD PRIMARY KEY(user_name);
      SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE admins
        DROP PRIMARY KEY; 
    SQL

    drop_table :admins
  end
end