class BookController < ApplicationController
  before_filter :validate_admin
	def index
    	@books=Book.all
  	end

  	def show
  	end

    def request_list
      @req_book = BookRequest.where(:status=>"Requested")
    end

    def hndl_bk_req
      type = params[:type]
      isbn = params[:isbn]
      puts isbn
      handle_book_request type,isbn
      redirect_to ("/admin/show/" + session[:user_name])
    end

    def handle_book_request type,isbn
      if type == "A"
        puts "Accept"
        @br = BookRequest.find_by_isbn(isbn)
        Book.create(:isbn=>@br.isbn,:title=>@br.title,:authors=>@br.author,:description=>@br.description)
        puts @br.present?
        @br.update_attributes(:status=>"HandledA")

      elsif type == "R"
        puts "Reject"
        BookRequest.update(status:"HandledR")
      end        
      puts "return"
    end

  	def new
   		@book = Book.new
  	end

  	def edit
         puts "isbn is: " + params[:isbn]
         @book=Book.find_by_isbn(params[:isbn])
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

    def delete_book
      ret = Book.destroy(params[:isbn])
      if ret
        flash[:notice]="Successfully Deleted Library Patrons from System!"
      else
        flash["Some error in delete"]
      end
      redirect_to "/admin/show/" + session[:user_name]
    end

  	def destroy
    	@book.destroy
    	respond_to do |format|
       		redirect_to books_url
    	end
  	end

  	def update
        set_book
    	if @book.update(book_params)
        	redirect_to "/admin/show/" + session[:user_name], notice: 'Book was successfully updated.'
      	else
        	redirect_to "/admin/search/" + session[:user_name], notice: 'Failed to checkout book.' 
      	end
    end

    def view_all_book
      @book_list = Book.all
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
      		@book=Book.where(isbn: params[:isbn]).first
    	end

    	# Never trust parameters from the scary internet, only allow the white list through.
    	def book_params
      		params.require(:book).permit(:isbn,:title,:authors,:description,:status)
    	end
end
