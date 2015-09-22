class Request < ActiveRecord::Base
	belongs_to :book,:user

	def check_valid
    if  self.where(user_name:self.user_name).count == 0
    	flash[:notice] = "User doesn't exist"
        return false
    else
        return true
    end 
end
