# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destination, type: :model do
  context 'Assosiations' do
    it { should validate_presence_of(:destination_point) }
  end
end
