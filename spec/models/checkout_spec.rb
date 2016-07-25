require 'rails_helper'

RSpec.describe Checkout, type: :model do
  
  it { should validate_presence_of(:bill_f_name).with_message(I18n.t(:'enter.billing_data.first_name')) }
  it { should validate_presence_of(:bill_l_name).with_message(I18n.t(:'enter.billing_data.last_name')) }
  it { should validate_presence_of(:bill_street).with_message(I18n.t(:'enter.billing_data.street')) }
  it { should validate_presence_of(:bill_city).with_message(I18n.t(:'enter.billing_data.city')) }
  it { should validate_presence_of(:bill_country).with_message(I18n.t(:'enter.billing_data.country')) }
  it { should validate_presence_of(:bill_zip).with_message(I18n.t(:'enter.billing_data.zip')) }
  it { should validate_presence_of(:bill_phone).with_message(I18n.t(:'enter.billing_data.phone')) }
  
  it { should validate_presence_of(:card_code).with_message(I18n.t(:"enter.card_code")) }
  it { should validate_numericality_of(:card_code).with_message(I18n.t(:"enter.code_numbers")) }
  
  it { should validate_presence_of(:card_number).with_message(I18n.t(:"enter.16_digits")) }
  
  it { should validate_numericality_of(:card_number).with_message(I18n.t(:"enter.1card_only_num")) }
  
  
  
end