require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET#new' do
    it 'assigns a new user as @user' do
      get :new

      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST#create' do
    context 'receives valid params' do
      it 'saves user and redirects to root path' do
        post :create, params: { user: attributes_for(:user) }

        expect(User.count).to eq(1)
        expect(assigns(:user)).to be_persisted
        expect(assigns(:user)).to be_a(User)
        expect(session[:user_id]).to eq(User.last.id)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'receives invalid params' do
      it 'flashes failure and redirects back to log-in path' do
        post :create, params: { user: attributes_for(:user, email: nil)}

        expect(User.count).to eq(0)
        expect(assigns(:user)).to be_a_new(User)
        expect(controller).to set_flash[:failure]
        expect(response).to redirect_to(new_user_path)
      end
    end
  end
end
