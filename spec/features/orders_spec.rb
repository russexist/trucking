# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Orders', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  describe '#create' do
    before do
      sign_in(user)
      visit new_order_path
      expect(page).to have_content(I18n.t('orders.new.title'))
    end

    context 'when data is valid' do
      scenario 'creates order' do
        fill_in 'order[start]', with: order.start
        click_button I18n.t('orders.form.next')
        fill_in 'order[destination]', with: order.destination
        click_button I18n.t('orders.form.next')
        fill_in 'order[date]', with: order.date
        fill_in 'order[price]', with: order.price
        fill_in 'order[weight]', with: order.weight
        click_button I18n.t('common.save')
        accept_alert
        expect(page).to have_content(I18n.t('orders.created'))
      end
    end

    context 'when data is invalid' do
      scenario 'does not create order' do
        fill_in 'order[start]', with: 'invalid data'
        click_button I18n.t('orders.form.next')
        fill_in 'order[destination]', with: 'invalid data'
        click_button I18n.t('orders.form.next')
        fill_in 'order[weight]', with: ' '
        fill_in 'order[price]', with: ' '
        click_button I18n.t('common.save')
        accept_alert do
          expect have_content('Geocode was not successful for the following reason: ZERO_RESULTS')
        end
      end
    end

    context 'when data is empty' do
      scenario 'does not create order' do
        click_button I18n.t('orders.form.next')
        fill_in 'order[destination]', with: ''
        click_button I18n.t('orders.form.next')
        fill_in 'order[weight]', with: ' '
        fill_in 'order[price]', with: ' '
        click_button I18n.t('common.save')
        expect(page).to have_content(I18n.t('common.errors'))
      end
    end
  end
end
