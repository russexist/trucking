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

  describe '.scope' do
    let(:users) { create_list(:user, 3) }

    before(:each) do
      users.last(2).map { |u| u.update(driver: true) }
    end

    it 'returns all drivers' do
      expect(User.drivers.size).to eq(2)
    end
  end

  describe '#full_name' do
    let(:user) { create(:user) }

    it 'returns user full name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe '#not_driver?' do
    let(:user) { create(:user) }

    context 'when user driver' do
      before { user.update(driver: true) }

      it { expect(user.driver.blank?).to be_falsy }
    end

    context 'when user not driver' do
      it { expect(user.driver.blank?).to be_truthy }
    end
  end

  describe '#photo?' do
    let(:user) { create(:user) }

    context 'when user has photo' do
      before { user.build_avatar }

      it { expect(user.avatar.present?).to be_truthy }
    end

    context "when user doesn't have photo" do
      it { expect(user.avatar.present?).to be_falsy }
    end
  end
end
