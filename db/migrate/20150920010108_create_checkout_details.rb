class CreateCheckoutDetails < ActiveRecord::Migration
  def up
    create_table :checkout_details, {id: false} do |t|
      t.string "isbn",              :limit => 13  , :null => false, :unique => true
      t.string "user_name",         :limit => 50  , :null => false
      t.datetime "checkout_date", :null => false
      t.datetime "return_date"
      t.datetime "actual_return_date"
      t.string "checkout_status",   :limit => 10  , :null => false
      t.timestamps null: false
      #add_foriegn_key :isbn, :books
      #add_foriegn_key :user_name, :users
    end
  end

  def down
    drop_table:checkout_details
  end
end
