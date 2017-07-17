require 'rails_helper'

RSpec.describe LinksController do
  describe 'GET#index' do
    context 'user not logged in' do
      it 'redirects the user to sessions_new path' do
        get(:index)

        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'authenticated user' do
      it 'renders index template' do
        user = create(:user)
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)

        get(:index)
        expect(response).to render_template(:index)
      end
    end
  end
end
