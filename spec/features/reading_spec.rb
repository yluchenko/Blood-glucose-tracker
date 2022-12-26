require 'rails_helper'

describe 'Reading', type: :feature, js: true, driver: :selenium_chrome do
  let(:user) { create(:user) }
  before do
    login_as(user)
    3.times { user.readings.create(level: 4) }
    visit('/')
  end
  it 'add glucose level' do
    click_button 'Add Glucose Reading'
    fill_in 'reading_level',  with: 10
    click_button 'Create Reading'
    expect(page).to have_content('Level is too long (maximum is 1 character)')

    fill_in 'reading_level', with: 1
    click_button 'Create Reading'
    expect(page).to have_content('Glucose level was successfully added.')

    click_button 'Add Glucose Reading'

    fill_in 'reading_level', with: 1

    click_button 'Create Reading'
    expect(page).to have_content('Level can only be store 4 times per day')
  end
end
