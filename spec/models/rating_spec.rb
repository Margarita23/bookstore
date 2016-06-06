require 'rails_helper'

RSpec.describe Rating, type: :model do

  it { should belong_to(:book) }
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:review) }
  it { should validate_presence_of(:headline) }
  it { should validate_length_of (:review) }
  
end