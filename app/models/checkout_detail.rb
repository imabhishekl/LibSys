class CheckoutDetail < ActiveRecord::Base
	self.primary_key="isbn"

	def self.checkout_list user_name,isbn,requested_by,is_all
		puts "ASLTECH:BOOK"
		puts is_all
		puts user_name
		puts is_all
		if is_all == "1"
			CheckoutDetail.all
		elsif user_name && isbn
			#extract by both username and isbn
			puts "s & i"
			CheckoutDetail.where(:user_name => user_name,:isbn => isbn)
		elsif user_name
			#extract by username
			CheckoutDetail.where(:user_name => user_name)
		elsif isbn
			#extract by isbn
			CheckoutDetail.where(:isbn => isbn)
		else
			CheckoutDetail.where(:checkout_status => "CheckedOut")
		end
	end

	def self.insert_in_chkout_dtls u_name,isbn
		CheckoutDetail.create(isbn: isbn,
							  user_name: u_name,
							  checkout_date: Date.today,
							  return_date: Date.today + 3.month,
							  checkout_status: "CheckedOut")
	end
end