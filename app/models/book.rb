class Book < ActiveRecord::Base
	self.primary_key="isbn"

	def self.search_results search_type,search_key
		puts "ASLTECH"
		if search_type.eql?("isbn")
			puts "ASLTECH:ISBN"
			where("isbn like ?","%#{search_key}%")
		elsif (search_type.eql?("author"))
			where("authors like ?","%#{search_key}%")
		elsif (search_type.eql?("title"))
			where("title like ?","%#{search_key}%")
		elsif (search_type.eql?("description"))
			where("description like ?","%#{search_key}%")
		elsif (search_type.eql?("available"))
			where(:status => "Available")
		else
			all()
		end
	end

	def checkout
  		if self.status=='checked-out'
     		return false 
  		elsif self.update(isbn: self.isbn) 
        	return true
     	else
       		return false
     	end 
  	end
end