class CreateAdminUser < ActiveRecord::Migration
  def up
	Admin.create(:user_name=>"imab",:name=>"abhishek",:password=>Base64.encode64("admin"),
				:email=>"test@test.com",:primary_ind=>"Y")
  end
end

