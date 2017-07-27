require 'rails_helper'

RSpec.describe 'Editing a link' do
  let(:user) { create(:user_with_links) }

  before(:each, authenticated: true) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  context 'user clicks edit', authenticated: true do
    it 'redirects user to edit link page' do
      link_1, link_2 = user.links

      visit links_path

      within('.link:first') do
        click_on('Edit')
      end

      expect(current_path).to eq(edit_link_path(link_2))
      expect(page).to have_css('h1', text: 'Edit Link')
      expect(page).to have_field('link[title]')
      expect(page).to have_field('link[url]')
      expect(page).to have_button('Update Link')
    end
  end

  context 'with valid inputs' do
    scenario 'user edits link', authenticated: true do
      link_1, link_2 = user.links

      title = 'New Title'
      url = 'http://www.newurl.com'

      visit edit_link_path(link_2)

      fill_in('link[title]', with: title)
      fill_in('link[url]', with: url)
      click_on 'Update Link'

      expect(current_path).to eq(links_path)
      within('#links') do
        expect(page).to have_content(title)
        expect(page).to have_content(url)
      end
      expect(user.links.count).to eq(2)
    end
  end
end
