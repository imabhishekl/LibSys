class UserController < ApplicationController
	before_filter :validate_user

  	def index
    	@users=User.all
  	end

 	def new
    	@user = User.new
  	end

    def edit
    end

  	def create
        params[:user]["password"]=Base64.encode64(params[:user]["password"])
    	@user = User.new(user_params)

    	begin
        	@user.save!
    	rescue Exception=> e
        	if e.is_a?ActiveRecord::RecordNotUnique
        		flash[:notice]="The user_name is not unique.The Form was not saved."
           		render action: 'new'
                        return 
        	else
                        raise "error"
        	end
    	end
        flash[:notice]='User was successfully created.'
        redirect_to ("/admin/show/"+ session[:user_name]) 
  	end

        def search
                if params[:search_type]
                @books=Book.search_results params[:search_type],params[:search_key]
        else
                #render search page without any result
        end
        end

 	def destroy
    	@user.destroy
    	respond_to do |format|
       	  redirect_to users_url
    	end
  	end

  	def update
    	respond_to do |format|
      		if @user.update(user_params)
        		redirect_to @user, notice: 'User was successfully updated.' 
      		else
        		render action: 'edit'
      		end
    	end
  	end

	def show 
		#valid request from legitemamte user
	end

	def validate_user
		if is_valid_user_request(params[:user_name])
			#valid request from legitemamte user
		else
			redirect_to "/login/show"
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:user_name,:name,:password,:email_id,:status)
    end
end
