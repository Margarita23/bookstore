class CategoriesController < ApplicationController
  include CategoriesHelper
  load_and_authorize_resource

  def show
  end
end