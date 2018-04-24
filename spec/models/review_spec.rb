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

  describe '.scope' do
    let(:driver) { create(:user, driver: true) }
    let(:user) { create(:user) }

    before do
      create(:review, user: user, driver: driver)
    end

    it 'returns reviews for driver' do
      expect(Review.for_driver(driver).size).to eq(1)
    end
  end
end
