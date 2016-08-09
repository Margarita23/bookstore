class SetLessQuantityService
  def initialize(item, book)
    @item = item
    @book = book
  end
  
  def call
    if @item.quantity > @book.quantity
      @item.update_attributes(quantity: @book.quantity)
      message_about_quantity_books(@book)
    else
      I18n.t(:books_added)
    end
  end
  
  private
  
  def message_about_quantity_books(book)
    I18n.t(:books_in_store_1) + "#{book.quantity}" + I18n.t(:books_in_store_2)
  end 
end