class AdminController < ApplicationController
	before_filter :validate_admin

	def index
    	@admins=Admin.all
  	end

	def show
		#valid request from legitemamte user
	end

  def checked_book_list
    checkout_list params[:u_name] params[:isbn] session[:is_admin]
  end

	def validate_admin
    puts "validate_admin"
    puts params[:user_name]
    puts session[:is_admin]
		if is_valid_user_request(params[:user_name]) && session[:is_admin].eql?(YES)
			#valid request from legitemamte user
		else
			redirect_to "/login/show"
		end
	end

	def search
		puts "ASLTCH:search"
    puts params[:search_type]
		if params[:search_type]
     		@books=Book.search_results params[:search_type],params[:search_key]
     		puts "ASLTECH : COUNT : " + @books.count.to_s
     	else
     		#render search page without any result
     	end
	end

	  def new
      @admin = Admin.new
  	end

  	def edit
  	end

  	def create
    	@admin = Admin.new(admin_params)

    	begin
        	@admin.save!
    	rescue Exception=> e 
        	if e.is_a?ActiveRecord::RecordNotUnique 
           		flash[:notice]="The user_name is not unique.The Form was not saved."
           		render action: 'new'
        	else 
          		flash[:notice]='Admin was successfully created.'
           		redirect_to "/admin/show/" + session[:user_name] 
        	end
    	end
  	end

  	def destroy
    	@admin.destroy
     	redirect_to admins_url
  	end

  	def update
    	if @admin.update(admin_params)
        	redirect_to @admin, notice: 'Admin was successfully updated.'
      	else
        	render action: 'edit'
      	end
  	end

  	def checkout
    	isbn=params[:isbn]
      u_name=params[:u_name] 
      puts "ASLTECH <=>" + params[:u_name]
      if User.isValid?(u_name)
        puts "User is valid"
        if Book.find_by_isbn(isbn).update(status:"checkout")
          flash[:notice] = "Book Checked out"
          redirect_to "/admin/show/" + session[:user_name]
        else
          flash[:notice] = "Failed to checkout book"
          redirect_to "/admin/show/" + session[:user_name]
        end
      else
        flash[:notice] = "User is invalid"
      	redirect_to '/admin/show/' + session[:user_name]
      end
  	end

  
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
    	@admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
    	params.require(:admin).permit(:user_name,:name,:password,:email_id,:primary_ind)
    end

    private :set_admin, :admin_params
end