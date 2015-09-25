class SignupController < ApplicationController
	def show
          @user=User.new
	end	
     
        def create
           if params[:user]["user_name"] !~ /^.+@.+\..+$/i 
              flash[:notice]="Invalid Username. Please check and try again"
              redirect_to ("/signup/show")
           end   

           params[:user]["password"]=Base64.encode64(params[:user]["password"])
           @user = User.new(user_params)

        begin
                @user.save!
        rescue Exception=> e
                if e.is_a?ActiveRecord::RecordNotUnique
                        flash[:notice]="The user_name is not unique.The Form was not saved."
			redirect_to ("/login/show/")
                        return
                else
                        raise e 
                end
        end
          flash[:notice]='User was successfully created.'
          redirect_to ("/login/show/")
        end
   
    private
    def user_params
       params.require(:user).permit(:user_name,:name,:password)
    end

end
