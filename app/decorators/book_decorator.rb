#BookDecorator
class BookDecorator < Draper::Decorator
  delegate_all

  def authors_link
    " #{author_first_name} #{author_last_name}"
  end

  def author_first_name
    object.first_name
  end

  def author_last_name
    object.last_name
  end
end
