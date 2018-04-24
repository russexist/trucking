# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Orders', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  subject { page }

  describe '#create' do
    before(:each) do
      sign_in(user)
      visit new_order_path
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

        is_expected.to have_content(I18n.t('orders.created'))
      end
    end

    context 'when data is invalid' do
      let(:msg) { 'Geocode was not successful for the following reason: ZERO_RESULTS' }

      scenario 'does not create order' do
        fill_in 'order[start]', with: 'invalid data'

        click_button I18n.t('orders.form.next')

        fill_in 'order[destination]', with: 'invalid data'

        click_button I18n.t('orders.form.next')

        fill_in 'order[weight]', with: ' '
        fill_in 'order[price]', with: ' '

        click_button I18n.t('common.save')

        expect(accept_alert).to have_content(msg)
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

        is_expected.to have_content(I18n.t('common.errors'))
      end
    end
  end

  describe '#update' do
    before { sign_in(user) }

    scenario 'updates order' do
      visit edit_order_path('ru', order)

      click_button I18n.t('orders.form.next')

      fill_in 'order[destination]', with: order.destination

      click_button I18n.t('orders.form.next')

      fill_in 'order[price]', with: '550'
      fill_in 'order[weight]', with: '200'

      click_button I18n.t('common.save')

      is_expected.to have_content("#{I18n.t('orders.index.price')}: 550")
    end
  end

  describe '#destroy' do
    before { sign_in(user) }

    scenario 'deletes order' do
      visit order_path('ru', order)

      click_link I18n.t('common.delete')

      accept_confirm

      is_expected.to have_content(I18n.t('orders.deleted'))
    end
  end
end
