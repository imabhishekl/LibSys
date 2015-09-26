class LoginController < ApplicationController
	def show
		#NotificationMail.send_notification ('aslingw@ncsu.edu')
		#login form
	end

	def login_auth
                puts "User-name at login_auth is " + params[:user_name]
		if params[:type].eql?(ADMIN)
			puts "Authencating admin"
			@authorized_user = Admin.authenticate(params[:user_name],params[:password])
		else
			puts "Authencating user"		
			@authorized_user = User.authenticate(params[:user_name],params[:password])
		end
		
		puts @authorized_user

		if @authorized_user
			flash[:notice] = "Successfully logged in as #{@authorized_user.user_name}"
			session_start params[:type],@authorized_user
            handle_redirect params[:type],@authorized_user.user_name
		else
			flash[:notice] = "Invalid Username or Password. Please check and try again"
            flash[:color]=   "invalid"
			redirect_to ("/login/show")
		end
	end

	def logout
		puts "ASLTECH:LOGOUT"
		session_destroy
		redirect_to root_url
	end

	def handle_redirect type,user_name
		if params[:type].eql?(ADMIN)
			redirect_to(:controller => 'admin', :action => 'show', :user_name => user_name)
		else
			redirect_to("/user/show/" + user_name	)
		end
	end
end
