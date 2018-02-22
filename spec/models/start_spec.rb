# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Start, type: :model do
  context 'Assosiations' do
    it { should validate_presence_of(:starting_point) }
  end
end
