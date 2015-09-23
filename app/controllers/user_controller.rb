class UserController < ApplicationController
	before_filter :validate_user

  	def index
    	@users=User.all
  	end

 	def new
    	@user = User.new
  	end

    def edit
        @user = User.find(params[:user_name])       
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
           @requests=Request.where(:user_name=>session[:user_name]) 
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
                set_user
                params[:user]["password"]= Base64.encode64(params[:user]["password"])   
      		if @user.update(user_params)
   		redirect_to "/user/show/" + session[:user_name], notice: 'User was successfully updated.' 
      		else
        		render action: 'edit'
      		end
  	end

	def show 
		#valid request from legitemamte user
	end

	def validate_user
		if is_valid_user_request(params[:user_name]) 
			#valid request from legitemamte user
		else
                        if session[:is_admin].eql?("YES")
			redirect_to "/login/show"
                        end 
		end
	end

        def checkout
        	isbn=params[:isbn]
        	if Book.find_by_isbn(isbn).update(status:"checkout")
                CheckoutDetail.insert_in_chkout_dtls(session[:user_name],isbn) 
          		flash[:notice] = "Book Checked out"
          		redirect_to "/user/show/" + session[:user_name]
        	else
          		flash[:notice] = "Failed to checkout book"
          		redirect_to "/user/show/" + session[:user_name]
        	end
        end

        def checkout_history
                @history=CheckoutDetail.checkout_list session[:user_name],nil, session[:user_name],nil
        end 
  
        def return_book
checkout_detail=CheckoutDetail.where(isbn:params[:isbn], user_name:params[:user_name], checkout_status: 'CheckedOut' ).first
book=Book.find_by_isbn(params[:isbn])

if checkout_detail.update(checkout_status:'Returned',actual_return_date: Date.today) && book.update(status:'Available')
                        puts 'GLEN in if : return_book' 
                        flash[:notice] = "Returned book successfully"
                        redirect_to "/user/show/" + session[:user_name]
                        return
             else
                        flash[:notice] = "Failed to return book"
                        redirect_to "/user/show/" + session[:user_name]
             end
        end

        def request_notif
         if Request.create(isbn: params[:isbn], user_name: session[:user_name] )
              flash[:notice]="Request registered" 
              redirect_to "/user/show/" + session[:user_name] 
              return
         else
              flash[:notice] = "Failed to create request"
              redirect_to "/user/show/" + session[:user_name]
         end
       end
 

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:user_name,:name,:password,:email_id,:status)
    end
end
