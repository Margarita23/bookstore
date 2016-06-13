class AuthorsController < ApplicationController
  
  load_and_authorize_resource
  
  def show
    @author = Author.find(params[:id])
  end
  
end
