require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "book get checked out" do
    # Multi-checkout book
    book = Book.find_by_isbn "ISBN5"
    assert book.checked_out?

    # Single checkout book
    book = Book.find_by_isbn "ISBN6"
    assert book.checked_out?

  end
  test "book has not got checked out" do
    book = Book.find_by_isbn "ISBN8"
    assert_not book.checked_out?

  end


  test "should not save a book with no isbn" do
    book = Book.new
    book.authors= "author"
    book.title= "title"
    book.description= "description"
    assert_not book.save
  end
end
