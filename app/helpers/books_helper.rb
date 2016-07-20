module BooksHelper
  def books_authors_link(book)
    " #{book.author.first_name} #{book.author.last_name}"
  end
end