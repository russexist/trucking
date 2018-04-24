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

  describe '.scope' do
    let(:driver) { create(:user, driver: true) }
    let(:user) { create(:user) }

    before do
      create(:order, user: user)
      create(:order, user: user, driver: driver, status: 1)
      create(:order, user: user, driver: driver, status: 2)
    end

    it 'returns archived orders for user' do
      expect(Order.archived_for_user(driver).size).to eq(1)
    end

    it 'returns taken orders by driver' do
      expect(Order.taken_by_driver(driver).size).to eq(1)
    end
  end

  describe '#format_date' do
    let(:user) { create(:user) }
    let(:order) { create(:order, date: '2018.01.21', user: user) }

    it 'returns formatted date' do
      expect(order.format_date).to eq('21/01/2018')
    end
  end
end
