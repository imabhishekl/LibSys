class CheckoutDetail < ActiveRecord::Base
	self.primary_key="isbn"

	def self.checkout_list user_name,isbn,requested_by
		puts "ASLTECH:BOOK"
		puts user_name
		puts isbn
		if user_name && isbn
			#extract by both username and isbn
			CheckoutDetail.where(:user_name => user_name,:isbn => isbn)
		elsif user_name
			#extract by username
			CheckoutDetail.where(:user_name => user_name)
		elsif isbn
			#extract by isbn
			CheckoutDetail.where(:isbn => isbn)
		else
			CheckoutDetail.all
		end
	end
end