module LineItemsHelper
  def set_quantity(book, new_qty)
    item = current_cart.line_items.find_by(book_id: book)
    if check_params(new_qty)
      quan = new_qty
      if !item.nil?
        item.quantity = item.quantity.to_i + quan.to_i
      else
        item = current_cart.line_items.build(book: book)
        item.quantity = quan.to_i
        item.price = book.price
      end 
      item
    end
  end
  
  def qty_less_books(item, book)
    if item.quantity > book.quantity
      item.quantity = book.quantity 
      item.save
      t(:books_in_store_1) + "#{book.quantity}" + t(:books_in_store_2)
    else
      t(:books_added)
    end
  end
  
  def check_params(new_qty)
    new_qty.to_i > 0 && !new_qty.nil?
  end
  
  def check_quantity(item, book, new_qty)
    if check_params(new_qty) && book.quantity >= new_qty.to_i
      true 
    else
      false
    end
  end
  
end
