# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Orders', type: :feature do
  context 'create new order' do
    let(:user) { create(:rand_user) }
    let(:order) { create(:order, user: user) }
    before do
      visit new_user_session_path

      fill_in 'Email Address', with: user.email
      fill_in 'Password', with: user.password

      click_button I18n.t('devise.sessions.new.sign_in')
    end

    scenario 'should be successfull' do
      visit new_order_path
      expect(page).to have_content(I18n.t('orders.new.title'))

      fill_in 'order[start]', with: order.start
      fill_in 'order[destination]', with: order.destination
      fill_in 'order[date]', with: order.date
      fill_in 'order[price]', with: order.price
      fill_in 'order[weight]', with: order.weight

      click_button I18n.t('common.save')

      expect(page).to have_content(I18n.t('orders.created'))
    end

    scenario 'should fail' do
      visit new_order_path
      expect(page).to have_content(I18n.t('orders.new.title'))

      click_button I18n.t('common.save')

      expect(page).to have_content(I18n.t('common.errors'))
    end
  end
end
