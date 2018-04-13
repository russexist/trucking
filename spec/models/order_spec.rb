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
end
