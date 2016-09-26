RailsAdmin.config do |config|

  config.authorize_with do
    unless current_user && current_user.admin
      redirect_to(
        main_app.root_path,
        alert: I18n.t(:authorize_please)
      )
    end
  end

  config.current_user_method { current_user }

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end

  ## == Cancan ==
 # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Order', 'User']
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app do
      except ['Address', 'LineItem', 'Delivery', 'CreditCard', 'BillingAddress', 'ShippingAddress']
    end
    state
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.model 'LineItem' do 
    visible false
  end
  
  config.model 'ShippingAddress' do 
    visible false
  end
  
  config.model 'BillingAddress' do 
    visible false
  end
  
  config.model 'CreditCard' do 
    visible false
  end
  
  config.model 'Cart' do 
    visible false
  end

  config.model 'Address' do 
    list do
      field :first_name
      field :last_name
      field :street
      field :city
      field :country
      field :zip
      field :phone
      field :user_billing_id
      field :user_shipping_id
      field :order_billing_id
      field :order_shipping_id
      field :created_at
      field :updated_at
    end
  end

  config.model 'Book' do
    list do
      sort_by :title
      field :title
      field :price
      field :quantity
      field :bought
      field :category
      field :cover_line
    end   
  end
  
  config.model 'Author' do
    list do
      sort_by :last_name
      field :last_name
      field :first_name
      field :biography
    end
  end
  
  config.model 'AverageCache' do 
    visible false
  end
  
  config.model 'Rate' do 
    visible false
  end
  
  config.model 'RatingCache' do 
    visible false
  end
  
  config.model 'Category' do
    list do
      field :title
      field :created_at
      field :updated_at
    end
  end
  
  config.model 'Delivery' do
    list do
      field :method
      field :price
    end
  end
  
  config.model 'Coupon' do
    edit do
      field :code
      field :discount
      field :user_id do
        searchable true
      end
    end
  end
  
  config.model 'Rating' do
    list do
      sort_by :user
      field :user
      field :headline
      field :review
      field :book
      field :admin_checking
    end
    
    edit do
      field :headline
      field :review
      field :admin_checking
    end
  end
  
  config.model 'OverallAverage' do 
    visible false
  end
  
  config.model 'Order' do
    list do
      sort_by :created_at
      field :created_at
      field :number
      field :total_price
      field :delivery
      field :coupon
      field :state
    end
    
    edit do
      field :state, :state
    end
  end 
end
