require 'rails_helper'

RSpec.describe SessionsController do
  describe 'GET#new' do
    it 'renders session#new template' do
      get(:new)

      expect(response).to render_template(:new)
    end
  end

  describe 'POST#create' do
    context 'with valid credentials' do
      it 'it sets session[:user_id] to logged in user' do
        user = create(:user)
        
        post :create, params: { session: { email: user.email, password: "password" } }

        expect(assigns[:user]).to eq(user)
        expect(session[:user_id]).to eq(user.id)
        expect(controller).to set_flash[:success]
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'flashes failure message and redirects to login' do
        post :create, params: { session: { email: 'test@test.com', password: 'password' } }

        expect(controller).to set_flash[:failure]
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'clears session and redirects to log in' do
      user = create(:user)
      session[:user_id] = user.id

      delete :destroy, params: {id: user.id}

      expect(session[:user_id]).to be(nil)
    end
  end
end
