class CreateAdminUser < ActiveRecord::Migration
  def up
	Admin.create(:user_name=>"boss@admin.com",:name=>"abhishek",:password=>Base64.encode64("libsys@admin"),
				:primary_ind=>"Y")
  end
end

