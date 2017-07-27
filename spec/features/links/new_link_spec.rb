require 'rails_helper'

RSpec.describe 'Submitting a new link', js: true do
  let(:user) { create(:user) }

  before(:each, authenticated: true) do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)
  end


  context 'with valid inputs' do
    scenario 'user adds a new link to their bookmarks', authenticated: true do
      title = 'new title'
      url = 'http://www.google.com'

      visit root_path

      fill_in('link[title]', with: title)
      fill_in('link[url]', with: url)
      click_on 'Add Link'

      within('.link') do
        expect(page).to have_css('p.link-title', text: "Title: #{title}")
        expect(page).to have_css('p.link-url', text: "URL: #{url}")
        expect(page).to have_css('p.read-status', text: 'Read?: false')
        expect(page).to have_button('Mark as Read')
        expect(page).to have_button('Edit')
      end

      expect(current_path).to eq(root_path)

      expect(user.links.count).to eq(1)
      expect(user.links.last.title).to eq(title)
      expect(user.links.last.url).to eq(url)
      expect(user.links.last.read).to eq(false)
    end
  end

  context 'with invalid inputs', authenticated: true do
    scenario 'missing title' do
      url = 'http://www.google.com'

      visit root_path

      fill_in('link[url]', with: url)
      click_on 'Add Link'

      expect(current_path).to eq(root_path)
      within('.errors') do
        expect(page).to have_css('p.error', text: "Title can't be blank.")
      end
      expect(user.links.count).to eq(0)
    end

    scenario 'missing url' do
      title = 'new title'

      visit root_path

      fill_in('link[title]', with: title)
      click_on 'Add Link'

      expect(current_path).to eq(root_path)
      within('.errors') do
        expect(page).to have_css('p.error', text: "Url can't be blank.")
      end
      expect(user.links.count).to eq(0)
    end

    scenario 'missing url and title', authenticated: true do
      visit root_path

      click_on 'Add Link'

      expect(current_path).to eq(root_path)
      within('.errors') do
        expect(page).to have_css('p.error', text: "Url can't be blank.")
        expect(page).to have_css('p.error', text: "Title can't be blank.")
      end
      expect(user.links.count).to eq(0)
    end
  end
end
