require 'rails_helper'

RSpec.describe LinksController do
  describe 'GET#index' do
    context 'user not logged in' do
      it 'redirects the user to sessions_new path' do
        get :index

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'authenticated user' do
      it 'renders index template' do
        user = create(:user)
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)

        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET#edit' do
    it 'renders edit template' do
      user = create(:user_with_links)
      link_1, _link_2 = user.links
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get :edit, params: { id: link_1.id }

      expect(assigns[:link]).to eq(link_1)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST#update' do
    context 'with valid params' do
      it 'updates that link with new attributes' do
        user = create(:user_with_links)
        link_1, _link_2 = user.links
        new_url = 'http://www.newurl.com'
        new_title = 'New Title'
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)

        patch :update, params: { id: link_1.id, link: { url: new_url, title: new_title } }

        expect(assigns[:link]).to eq(link_1)
        expect(assigns[:link].title).to eq(new_title)
        expect(assigns[:link].url).to eq(new_url)
        expect(response).to redirect_to(links_path)
      end
    end

    context 'with invalid params' do
      scenario 'title is blank' do
        user = create(:user_with_links)
        link_1, link_2 = user.links
        new_url = ''
        new_title = 'New Title'
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)

        patch :update, params: { id: link_1.id, link: { url: new_url, title: new_title } }

        expect(assigns[:link]).to eq(link_1)
        expect(controller).to set_flash[:failure]
        expect(response).to redirect_to(edit_link_path(link_1.id))
      end
    end
  end
end
