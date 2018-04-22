# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:driver) }
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:notifications).dependent(:destroy) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:destination) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:start) }
    it { is_expected.to validate_presence_of(:weight) }
  end

  describe '.enum' do
    it { is_expected.to define_enum_for(:status).with(%i[new_order taken delivered]) }
  end

  context 'scope' do
    let(:driver) { create(:rand_user, driver: true) }
    let(:user) { create(:rand_user) }
    before do
      create(:rand_order, user: user)
      create(:rand_order, user: user, driver: driver, status: 1)
      create(:rand_order, user: user, driver: driver, status: 2)
    end

    it 'should return archived orders for user' do
      expect(Order.archived_for_user(driver).size).to eq(1)
    end

    it 'should return taken orders by driver' do
      expect(Order.taken_by_driver(driver).size).to eq(1)
    end
  end

  describe 'function format_date' do
    let(:user) { create(:rand_user) }
    let(:order) { create(:order, user: user) }

    it 'should return formatted date' do
      expect(order.format_date).to eq('21/01/2018')
    end
  end
end
