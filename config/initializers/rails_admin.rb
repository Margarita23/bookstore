RailsAdmin.config do |config|
  
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'margo' && password == 'mamapapa'
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  #config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

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
  
  config.model 'Address' do 
    visible false
  end
  
  config.model 'CreditCard' do 
    visible false
  end
  
  config.model 'Cart' do 
    visible false
  end

  config.model 'Book' do
    list do
      sort_by :title
      field :title do
        sort_reverse false
      end
      field :bought do
        sort_reverse false
      end
    end
  end
  
  config.model 'Order' do
    list do
      sort_by :created_at
      field :number
      field :total_price
      field :delivery
    end
    
    edit do
      field :state, :enum do
        enum do
          ['in_progress', 'shipped','completed']
        end
      end
      field :state do
        label "Order State"
      end
    end
  end
  
  
  
end
