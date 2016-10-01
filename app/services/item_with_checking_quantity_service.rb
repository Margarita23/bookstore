# ItemWithCheckingQuantityService
class ItemWithCheckingQuantityService
  def initialize(book_id, new_quantity, current_cart)
    @book = Book.find_by(id: book_id)
    @new_qty = new_quantity
    @current_items = current_cart.line_items
  end

  def call
    return nil if @book.nil?
    item = @current_items.find_by(book_id: @book)
    return item unless check_params(@new_qty)
    if item.nil?
      item = add_new_item(@book, @new_qty)
    else
      item.quantity += @new_qty.to_i
    end
    item
  end

  private

  def check_params(new_qty)
    new_qty.to_i > 0 && !new_qty.nil?
  end

  def add_new_item(book, new_qty)
    @current_items.build(book: book, quantity: new_qty.to_i, price: book.price)
  end
end
