// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
function ask_user_name(admin_user_name,isbn)
{
	var u_name = prompt("Please enter the user_name for which checkout is requested")
	if (u_name != null)
	{
		window.location="http://localhost:3000/admin/checkout/" + admin_user_name + 
						"?u_name=" + u_name + "&isbn=" + isbn;
	}
}