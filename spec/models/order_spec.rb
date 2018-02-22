# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Assosiations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:weight) }
  end
end
