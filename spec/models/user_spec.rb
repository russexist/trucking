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

  describe '#full_name' do
    let(:user) do
      User.create(first_name: 'Ruslan', last_name: 'Oliinyk', email: '1@2.ua')
    end

    it 'should return user full name' do
      expect(user.full_name).to eq('Ruslan Oliinyk')
    end
  end
end
