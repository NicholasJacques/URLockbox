require 'rails_helper'

RSpec.describe 'show read' do
  it 'only shows links that have been read', js: true do
    user = create(:user)
    link_1 = create(:link, user: user, read: true)
    link_2 = create(:link, user: user, read: true)
    link_3 = create(:link, user: user, read: false)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

      visit links_path

      within('#links') do
        expect(page).to have_content(link_1.title)
        expect(page).to have_content(link_2.title)
        expect(page).to have_content(link_3.title)
      end

      within('.filters') do
        click_on 'Show Read'
      end

      within('#links') do
        expect(page).to have_content(link_1.title)
        expect(page).to have_content(link_2.title)
        expect(page).to_not have_content(link_3.title)
      end
  end
end
