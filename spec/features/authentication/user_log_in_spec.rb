require 'rails_helper'

RSpec.describe 'User log in process' do
  context 'with valid inputs' do
    scenario 'user logs in to their account' do
      user = create(:user)

      visit root_path

      expect(current_path).to eq(new_session_path)
      fill_in('session[email]', with: user.email)
      fill_in('session[password]', with: user.password)
      click_on 'Log In'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully logged in as #{user.email}")
      expect(page).to have_content('Log Out')
    end
  end

  context 'with invalid inputs' do
    scenario 'email is blank' do
      user = create(:user)

      visit new_session_path

      fill_in('session[password]', with: user.password)
      click_on 'Log In'

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content('Login Unsuccessful')
    end

    scenario 'password is blank' do
      user = create(:user)

      visit new_session_path

      fill_in('session[email]', with: user.email)
      click_on 'Log In'

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content('Login Unsuccessful')
    end

    scenario "user doesn't exist" do
      visit new_session_path

      fill_in('session[email]', with: 'bademail@test.com')
      fill_in('session[password]', with: 'password')
      click_on 'Log In'

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content('Login Unsuccessful')
    end

    scenario 'wrong password' do
      user = create(:user)

      visit new_session_path

      fill_in('session[email]', with: user.email)
      fill_in('session[password]', with: 'badpassword')
      click_on 'Log In'

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content('Login Unsuccessful')
    end
  end
end
