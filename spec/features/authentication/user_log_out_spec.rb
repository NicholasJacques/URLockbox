require 'rails_helper'

RSpec.describe 'User log out process' do
  scenario 'as an authenticated user visiting the index page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log Out')
    expect(page).to_not have_link('Sign Up')

    click_on 'Log Out'

    expect(current_path).to eq(new_session_path)
  end
end
