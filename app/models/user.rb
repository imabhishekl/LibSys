class User < ActiveRecord::Base
	self.primary_key="user_name"

	def self.authenticate(login_user_name,login_password)
       user = User.find_by_user_name(login_user_name)

       if user && user.match_password(login_password,user.password)
       	return user
       else
       	return false
       end
	end

  def self.isValid?(u_name)
    puts "ASLTECH=>" + u_name
    if exists?(:user_name => u_name)
      puts "true"
      return true
    else
      puts "false"
      return false
    end
  end

	def match_password(login_password,hashed_password)
       hashed_password == Base64.encode64(login_password)
    end
end
