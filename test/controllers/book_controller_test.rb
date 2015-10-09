require 'test_helper'

class BookControllerTest < ActionController::TestCase

  # setup a librarymember
  def setup
    user = admin.create!(:user_name => "xc123", :email => "xc123@gmail.com", :password => "abc123")
    session[:user_id] = user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(books)
  end

  test "should be able to search with author's name" do
    get :index, {"book_param" => "authors", "query" => "Author0"}
    assert_response :success
    assert_not_nil assigns :books

    assert_equal 1, assigns(:books).length
    assert "ISBN5", assigns(:books)[0].isbn
  end


  test "should be able to search by ISBN" do
    get :index, {"book_param" => "isbn", "query" => "0"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 5), "Incorrect number of books returned."
  end



  test "view new book as admin" do
    user = Admin.create!(:name => "xc123", :email => "xc123@gmail.com", :password => "abc123")
    session[:user_id] = user.id
    get :new
    assert_response :success
  end




  # test "the truth" do
  #   assert true
  # end
end
