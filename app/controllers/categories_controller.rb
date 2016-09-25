# CategoriesController
class CategoriesController < ApplicationController
  load_and_authorize_resource
  def show
    @categories = Category.all
  end
end
