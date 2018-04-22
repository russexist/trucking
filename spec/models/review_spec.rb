# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:driver) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  context 'scope' do
    let(:driver1) { create(:rand_user, driver: true) }
    let(:driver2) { create(:rand_user, driver: true) }
    let(:user) { create(:rand_user) }
    before do
      create(:review, user: user, driver: driver1)
      create(:review, user: user, driver: driver2)
    end

    it "should return reviews for driver" do
      expect(Review.for_driver(driver1).size).to eq(1)
    end
  end
end
