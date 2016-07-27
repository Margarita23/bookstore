module HomeHelper
  def bestsellers
    Book.bestsellers
  end
  
  def shopping
    Book.all
  end
end