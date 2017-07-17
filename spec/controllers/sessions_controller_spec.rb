require 'rails_helper'

RSpec.describe SessionsController do
  describe 'GET#new' do
    it 'renders session#new template' do
      get(:new)

      expect(response).to render_template(:new)
    end
  end
end
