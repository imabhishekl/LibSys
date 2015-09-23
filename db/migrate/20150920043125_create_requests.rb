class CreateRequests < ActiveRecord::Migration
  def up
    create_table :requests,id:false do |t|
      t.string :isbn,:limit => 13, :null => false
      t.string :user_name,:limit => 25, :null => false
      t.string :request_ind,:limit => 1, :null => false, :default => 'Y'
    end
  end

  def down
    drop_table :requests
  end
end
