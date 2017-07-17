require 'rails_helper'

RSpec.describe LinksController do
  describe 'GET#index' do
    context 'user not logged in' do
      it 'redirects the user to sessions_new path' do
        get(:index)

        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
