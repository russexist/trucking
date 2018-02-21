# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Assosiations' do
    it { is_expected.to validate_presence_of(:start_point) }
    it { should validate_presence_of(:finish_point) }
    it { should validate_presence_of(:price) }
  end
end
