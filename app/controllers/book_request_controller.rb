class BookRequestController < ApplicationController
  before_filter :validate_user
        def new
                @book_request = BookRequest.new
        end

        def validate_user
                if is_valid_user_request(params[:user_name])
                        #valid request from legitemamte user
                else
                        redirect_to "/login/show"
                end
        end

  	def create
   		@book_request = BookRequest.new(book_params)

        	@book_request.save!
        flash[:notice]='Book request created. Admin will review the request.'
        redirect_to ("/user/show/" + session[:user_name])
  	end

        def edit
         puts "isbn is: " + params[:isbn]
         @book_request=BookRequest.find_by_isbn(params[:isbn])
        end

        def update
                puts "Glen isbn is: " + params[:book_request][:isbn] 
                @book_request=BookRequest.find_by_isbn(params[:book_request][:isbn])
        	if @book_request.update(book_params)
                	redirect_to "/book/request_list/" + session[:user_name], notice: 'updated request details.'
        	else
                	redirect_to "/book/request_list/" + session[:user_name], notice: 'Failed to update details.'
        	end
        end

  	private
    	# Never trust parameters from the scary internet, only allow the white list through.
    	def book_params
      		params.require(:book_request).permit(:isbn,:title,:author,:description)
    	end
end
