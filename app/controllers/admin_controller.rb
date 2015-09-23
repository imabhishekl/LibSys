class AdminController < ApplicationController
	before_filter :validate_admin

	def index
    	@admins=Admin.all
  	end

	def show
		#valid request from legitemamte user
	end

  def edit_view
    @admin= Admin.find_by_user_name(session[:user_name])
    if @admin
      @admin
    else
      flash[:notice] = "Sorry some issue in fetching details"
      redirect_to "/admin/show/" + session[:user_name]
    end
  end

  def delete_admin
    if Admin.destroy(params[:admin_u_name])
      flash[:notice]="Successfully Deleted Admin #{params[:admin_u_name]} from System!"
    else
      flash["Some error in deleting admin"]
    end
      redirect_to "/admin/show/" + session[:user_name]
  end

  def delete_patrons
    ret = CheckoutDetail.destroy(params[:u_name])
    if ret
      User.destroy(params[:u_name])
      flash[:notice]="Successfully Deleted Library Patrons #{params[:u_name]} from System!"
    else
      flash["Some error in delete"]
    end
    redirect_to "/admin/show/" + session[:user_name]
  end

  def view_patrons 
    @patrons=User.all
  end

  def view_admin
    @admin_list=Admin.all
  end

  def checked_out_book_list
    puts "CHECKOUT"
    puts params[:u_name]
    puts params[:isbn]
    @book_list=CheckoutDetail.checkout_list params[:u_name],params[:isbn],session[:is_admin],params[:current]
    #redirect_to "/admin/checked_out_book_list/" + session[:user_name]
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

  	def update_admin
      params[:user][]
      if Admin.find_by_user_name(session[:user_name]).update(:name=>params[:admin][:name])
        flash[:notice]= params[:admin][:name] + ' was updated successfully.' 
      else
        flash[:notice]= params[:admin][:name] + ' was not updated successfully.'
      end
      redirect_to '/admin/show/' + session[:user_name]
  	end

  	def create
        params[:admin]["password"]=Base64.encode64(params[:admin]["password"])
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
          CheckoutDetail.insert_in_chkout_dtls u_name,isbn
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
    	params.require(:admin).permit(:user_name,:name,:password,:email,:primary_ind)
    end

    private :set_admin, :admin_params
end