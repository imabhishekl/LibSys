module LoginHelper
	ADMIN="admin"
	USER="user"
	YES="Y"

	def session_start type,user
		session[:user_name]=user.user_name
		if type.eql?(ADMIN)
			session[:is_admin]=YES
		end
	end

    def session_destroy
    	session.delete(:user_name)
    	session.delete(:is_admin)
	end

	def is_valid_user_request user_name
		if session[:user_name] && session[:user_name].eql?(user_name)
			return true
		else
			return false
		end
	end

end