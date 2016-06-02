class CheckoutController < ApplicationController
  include CartsHelper
  
  def new
    session[:checkout_params] ||= {}
    session[:checkout_params].deep_merge!(params[:checkout]) if params[:checkout]
    @checkout = Checkout.new(session[:checkout_params])
    @checkout.current_step = session[:checkout_step]
    session[:delivery] = @checkout.delivery
    @delivery = Delivery.find(session[:delivery])
    check_items
  end
  
  def create
    set_values
    ### what about case when ???
    if params[:address_button]
      @checkout.address_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:delivery_button]
      @checkout.delivery_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:payment_button]
      @checkout.payment_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:confirm_button]
      @checkout.confirm_step
      session[:checkout_step] = @checkout.current_step
      render 'new'
      
    elsif @checkout.last_step? 
      @checkout.save
      books_statistic
      get_line_items
      session[:checkout_step]= nil
      flash[:notice] = "Order saved."
      redirect_to complete_order_path(:order_id => @checkout.order)
    else
      @checkout.next_step
      session[:checkout_step] = @checkout.current_step
      render 'new'
    end
  end
  
  def complete
    @order = Order.find(params[:order_id])
  end
  
  private
  
  def get_line_items
    current_user.cart.line_items.each do |l|
      l.order_id = @checkout.order
      l.cart_id = nil
      l.save
    end
  end
  
  def books_statistic
    current_user.cart.line_items.each do |l|
      book = Book.find(l.book_id)
      book.bought += l.quantity
      book.quantity = book.quantity - l.quantity
      book.save
    end
  end
  
  def check_items
    if current_user.cart.line_items.count == 0
       flash[:alert] = "Ordering should be at least one book"
      redirect_to  shopping_path  
     end
  end
  
  def set_values
    session[:checkout_params].deep_merge!(params[:checkout]) if params[:checkout]
    @checkout = Checkout.new(session[:checkout_params])
    @checkout.current_step = session[:checkout_step]
    @checkout.user = current_user   
    if !@checkout.delivery.nil?
      @delivery = Delivery.find(@checkout.delivery) 
      @checkout.total_price =  sub_total + @delivery.price
    end
    @checkout.check_same_address
  end
  
end
