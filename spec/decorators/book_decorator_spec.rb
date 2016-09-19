require 'rails_helper'
describe BookDecorator do
  let!(:book) { FactoryGirl.create(:book).decorate }
  it "#author_first_name return author`s first_name" do
    expect(book.author_first_name).to eq book.author.first_name
  end
  
  it "#author_last_name return author`s last_name" do
    expect(book.author_last_name).to eq book.author.last_name
  end
  
  it "#authors_link return author`s first and last name" do
    expect(book.authors_link).to eq " #{book.author.first_name} #{book.author.last_name}"
  end
end