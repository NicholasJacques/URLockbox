require 'rails_helper'

RSpec.describe 'can mark links as unread', js: true do
  let(:user) { create(:user_with_links) }

  before(:each, authenticated: true) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  it 'Mark a link as unread', authenticated: true do
    link_1, link_2 = user.links
    link_2.update_attribute(:read, true)

    visit links_path

    within first('.link') do
      expect(page).to have_text('true')
      click_on 'Mark as Unread'
      expect(page).to have_text('false')
    end
  end
end
