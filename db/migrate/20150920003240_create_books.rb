class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books, {id: false} do |t|
      t.string "isbn", :limit => 13  , :null => false, :unique => true
      t.string "title",      :limit => 50  , :null => false
      t.string "authors",  :limit => 25  , :null => false
      t.string "description",  :limit => 50  , :null => false
      t.string "status",    :limit => 12  , :null => false, :default => "Available"
      t.timestamps null: false
    end
    execute %Q(ALTER TABLE books ADD PRIMARY KEY (isbn);)
  end

  def down
    drop_table:books
  end
end
