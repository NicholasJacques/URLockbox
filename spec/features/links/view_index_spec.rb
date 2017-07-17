require 'rails_helper'

RSpec.describe 'viewing the links index at an authenticated user' do
  xcontext 'as a user with previously submitted links' do
    it "lists all that user's links" do
      user = create(:user_with_links)
      link_1, link_2 = user.links

      visit links_path

      within('ul#all-links') do
        expect(page).to have_content(link_1.url)
        expect(page).to have_content(link_1.title)
        expect(page).to have_content(link_2.url)
        expect(page).to have_content(link_2.title)
      end
    end
  end
end
