require 'rails_helper'

RSpec.describe 'viewing the links index as an authenticated user' do
  context 'as a user with previously submitted links' do
    it "lists all that user's links" do
      user = create(:user_with_links)
      link_1, link_2 = user.links

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit links_path

      within('.link:first') do
        expect(page).to have_css('p.link-title', text: "Title: #{link_2.title}")
        expect(page).to have_css('p.link-url', text: "URL: #{link_2.url}")
        expect(page).to have_css('p.read-status', text: "Read? #{link_2.read}")
        expect(page).to have_button('Mark as Read')
        expect(page).to have_button('Edit')
      end

      within('.link:last') do
        expect(page).to have_css('p.link-title', text: "Title: #{link_1.title}")
        expect(page).to have_css('p.link-url', text: "URL: #{link_1.url}")
        expect(page).to have_css('p.read-status', text: "Read? #{link_1.read}")
        expect(page).to have_button('Mark as Read')
        expect(page).to have_button('Edit')
      end
    end

    it 'has a form to submit new links' do
      user = create(:user_with_links)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit links_path

      within('form.new-link') do
        expect(page).to have_field('link[title]')
        expect(page).to have_field('link[url]')
        expect(page).to have_button('Add Link')
      end
    end
  end
end
