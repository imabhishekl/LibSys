class RequestController < ApplicationController
  before_filter :validate_user
        def new
        	@request = Request.new
        end

        def index
        	@requests = Request.all
        end

	def show
  	end

  	def edit
  	end

  	def delete
  	end

        def validate_user
        	if is_valid_user_request(params[:user_name])
        		#valid request from legitemamte user
        	else
            		redirect_to "/login/show"
        	end
        end

        def create
                if session[:is_admin].eql?("YES") 
                	# validating if admin
                else
                        params[:request]["user_name"]=session[:user_name]
                end

              	@request = Request.new(request_params)
        begin
                @request.save!
        rescue Exception=> e
                if e.is_a?ActiveRecord::RecordNotUnique
                        flash[:notice]="The ISBN is not unique.The Form was not saved"
                        render action: 'new'
                else
                        raise e 
                end
        end
        if session[:is_admin].eql?("YES")
        	flash[:notice]='Request was successfully created.'
        	redirect_to ("/admin/show/" + session[:user_name])
        else
                flash[:notice]='Request was successfully created.'
                redirect_to ("/user/show/" + session[:user_name])
        end
        end

  	def update
  	end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_request
                @request=Request.where(isbn: param[:isbn]).first
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def request_params
                params.require(:request).permit(:isbn,:user_name)
        end

end
