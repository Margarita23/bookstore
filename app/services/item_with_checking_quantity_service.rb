class ItemWithCheckingQuantityService
  def initialize(book, new_quantity, current_cart)
    @book = book
    @new_qty = new_quantity
    @current_cart = current_cart
  end
  
  def call
    item = @current_cart.line_items.find_by(book_id: @book)
    if check_params(@new_qty)
      item.nil? ? item = add_new_item(@book, @new_qty) : item.quantity += @new_qty.to_i 
    end
    item
  end
  
  private
  
  def check_params(new_qty)
    new_qty.to_i > 0 && !new_qty.nil?
  end
  
  def add_new_item(book, new_qty)
    @current_cart.line_items.build(book: book, quantity: new_qty.to_i, price: book.price)
  end
end