# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:nullify) }

    it { is_expected.to have_one(:avatar).dependent(:destroy) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '.enum' do
    it { is_expected.to define_enum_for(:otp_module).with(%i[disabled enabled]) }
  end

  context 'scope' do
    let(:users) { create_list(:rand_user, 3) }
    before(:each) do
      users.last(2).map { |u| u.update(driver: true) }
    end

    it 'should return drivers' do
      expect(User.drivers.size).to eq(2)
    end
  end

  describe 'function full_name' do
    let(:user) { create(:user) }

    it 'should return user full name' do
      expect(user.full_name).to eq('Ruslan Oliinyk')
    end
  end
end
