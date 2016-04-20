json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :price, :quantity
  json.url book_url(book, format: :json)
end
