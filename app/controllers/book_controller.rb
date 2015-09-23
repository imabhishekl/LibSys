class BookController < ApplicationController
  before_filter :validate_admin
	def index
    	@books=Book.all
  	end

  	def show
  	end

  	def new
   		@book = Book.new
  	end

  	def edit
  	end

    def validate_admin
      if is_valid_user_request(params[:user_name]) && session[:is_admin].eql?(YES)
        #valid request from legitemamte user
      else
        redirect_to "/login/show"
      end
    end

  	def create
   		@book = Book.new(book_params)

    	begin
        	@book.save!
    	rescue Exception=> e
        	if e.is_a?ActiveRecord::RecordNotUnique
           		flash[:notice]="The ISBN is not unique.The Form was not saved"
           		render action: 'new'
        	else
                        raise "error"
        	end
    	end
        flash[:notice]='Book was successfully created.'
        redirect_to ("/admin/show/" + session[:user_name])
  	end

  	def destroy
    	@book.destroy
    	respond_to do |format|
       		redirect_to books_url
    	end
  	end

  	def update
    	if @book.update(book_params)
        	redirect_to @book, notice: 'Book was successfully updated.'
      	else
        	render action: 'edit' 
      	end
    end

  	def checkout
    	if @book.checkout
        	redirect to @book, notice: 'Book was successfully checked-out'
      	else
        	redirect to @books, notice: 'Book is currently not available'
      	end
  	end

  	private
    	# Use callbacks to share common setup or constraints between actions.
    	def set_book
      		@book=Book.where(isbn: param[:isbn]).first
    	end

    	# Never trust parameters from the scary internet, only allow the white list through.
    	def book_params
      		params.require(:book).permit(:isbn,:title,:authors,:description,:status)
    	end
end
