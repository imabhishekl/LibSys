class Admin < ActiveRecord::Base
	self.primary_key="user_name"

       def self.authenticate(login_user_name,login_password)
       admin = Admin.find_by_user_name(login_user_name)
       puts admin 

       if admin && admin.match_password(login_password,admin.password)
       	return admin
       else
       	return false
       end
	end

	def match_password(login_password,hashed_password)
        puts login_password
        puts hashed_password
       hashed_password == Base64.encode64(login_password)
    end	
end
