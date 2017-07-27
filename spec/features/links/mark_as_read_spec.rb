require 'rails_helper'

RSpec.describe 'can mark links as read', js: true do
  let(:user) { create(:user_with_links) }

  before(:each, authenticated: true) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  it 'Mark a link as read', authenticated: true do
    link_1, link_2 = user.links
    
    visit links_path

    within first('.link') do
      expect(page).to have_text("false")
      click_on "Mark as Read"
      expect(page).to have_text("true")
    end
  end
end
