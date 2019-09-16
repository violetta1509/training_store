require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:key) }
  end
end
