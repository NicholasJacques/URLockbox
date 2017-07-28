require 'rails_helper'

RSpec.describe 'link search filtering' do
  it 'filter can search by link title', js: true do
    user = create(:user)
    link_1 = create(:link, title: 'Test Title', user: user)
    link_2 = create(:link, title: 'Test Title 2', user: user)
    link_3 = create(:link, title: "doesn't match", user: user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit links_path

    expect(page).to have_field('search')

    fill_in 'search', with: 'Tes'

    within('#links') do
      expect(page).to have_content(link_1.title)
      expect(page).to have_content(link_1.url)
      expect(page).to have_content(link_2.title)
      expect(page).to have_content(link_2.url)
      expect(page).to_not have_content(link_3.title)
      expect(page).to_not have_content(link_3.url)
    end
  end
end
