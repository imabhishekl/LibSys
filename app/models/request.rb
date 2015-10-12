class Request < ActiveRecord::Base
	def self.get_notifier_list isbn
		where(:isbn=>isbn,:request_ind=>"Y")
	end

	def self.update_close_notification isbn
		find_by_isbn(isbn).update(:request_ind=>"N")
	end
end
