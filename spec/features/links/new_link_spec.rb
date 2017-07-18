require 'rails_helper'

RSpec.describe 'Submitting a new link', js: true do
  context 'with valid inputs' do
    scenario 'user adds a new link to their bookmarks' do
      user = create(:user)
      title = 'new title'
      url = 'http://www.google.com'
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      fill_in('link[title]', with: title)
      fill_in('link[url]', with: url)
      click_on 'Add Link'

      expect(current_path).to eq(root_path)
      expect(user.links.count).to eq(1)
      expect(user.links.last.title).to eq(title)
      expect(user.links.last.url).to eq(url)
      expect(user.links.last.read).to eq(false)
    end
  end
end
