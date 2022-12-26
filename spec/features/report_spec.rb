require 'rails_helper'

describe 'Report', type: :feature, js: true, driver: :selenium_chrome do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end
  context 'when no records are present' do
    it 'display message' do
      visit '/'
      expect(page).to have_content('No records were found')
    end
  end
  context 'when records are present' do
    before do
      4.times { |i| user.readings.create(level: i + 1) }
      5.times { user.readings.create(level: 9, created_at: rand((DateTime.now - 1.months)...DateTime.now)) }
    end
    it 'shows readings' do
      visit '/'
      expect(page).to have_content('Level')
      expect(page).to have_content('4mg/dl')
      expect(page).not_to have_content('5mg/dl')

      click_link('Daily')
      sleep(1)

      expect(page).not_to have_content('Level')
      ['Maximum', '4mg/dl', 'Minimum', '1mg/dl', 'Average', '2.5mg/dl'].each do |content|
        expect(page).to have_content(content)
      end

      click_link('Monthly')
      sleep(1)

      ['Maximum', '9mg/dl', 'Minimum', '1mg/dl', 'Average', '6.1111mg/dl'].each do |content|
        expect(page).to have_content(content)
      end

      fill_in 'q', with: Date.today
      click_button('Search')
      sleep(1)

      ['Maximum', '9mg/dl', 'Minimum', '9mg/dl', 'Average', '9mg/dl'].each do |content|
        expect(page).to have_content(content)
      end
    end
  end
end
