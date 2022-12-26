require 'rails_helper'

describe 'Login', type: :feature, js: true, driver: :selenium_chrome do
  let!(:user) { create(:user) }

  it 'login user' do
    visit('/')
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Reading')
  end
end
