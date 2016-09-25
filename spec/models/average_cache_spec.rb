require 'rails_helper'
RSpec.describe AverageCache, type: :model do
  it { should belong_to(:rater) }
  it { should belong_to(:rateable) }
end
