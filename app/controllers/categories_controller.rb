class CategoriesController < ApplicationController
  
  load_and_authorize_resource

  # GET /categories/1
  def show
    @categories = Category.all
  end
end