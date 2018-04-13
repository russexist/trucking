# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:actor) }
    it { is_expected.to belong_to(:notifiable) }
    it { is_expected.to belong_to(:recipient) }
  end
end
