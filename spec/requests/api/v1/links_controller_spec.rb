require 'rails_helper'

RSpec.describe 'Links API' do
  let(:user) { create(:user)}

  before(:each, authenticated: true) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new link associated with the current user', authenticated: true do
        new_url = 'https://www.google.com'
        new_title = 'Google'

        post '/api/v1/links', params: { link: { url: new_url, title: new_title } }
        returned_markup = response.body

        expect(returned_markup).to include(new_url)
        expect(returned_markup).to include(new_title)
        expect(response).to be_success
        expect(user.links.count).to eq(1)
      end
    end

    context 'with invalid params' do
      scenario 'missing title', authenticated: true do
        new_url = 'https://www.google.com'

        post '/api/v1/links', params: { link: { url: new_url, title: nil } }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response['errors']).to be_an(Array)
        expect(parsed_response['errors'].length).to be(1)
        expect(parsed_response['errors'].first).to eq("Title can't be blank")
      end

      scenario 'missing url', authenticated: true do
        new_title = 'Good Title'

        post '/api/v1/links', params: { link: { url: nil, title: new_title } }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response['errors']).to be_an(Array)
        expect(parsed_response['errors'].length).to be(1)
        expect(parsed_response['errors'].first).to eq("Url can't be blank")
      end

      scenario 'missing title & url', authenticated: true do
        post '/api/v1/links', params: { link: { url: nil, title: nil } }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response['errors']).to be_an(Array)
        expect(parsed_response['errors'].length).to be(2)
        expect(parsed_response['errors']).to include("Title can't be blank")
        expect(parsed_response['errors']).to include("Url can't be blank")
      end

      scenario 'invalid url', authenticated: true do
        new_url = 'badurl.com'
        new_title = 'Google'

        post '/api/v1/links', params: { link: { url: new_url, title: new_title } }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response['errors']).to be_an(Array)
        expect(parsed_response['errors'].length).to be(1)
        expect(parsed_response['errors']).to include('Url is invalid')
      end

      scenario 'no authenticated user' do
        new_url = 'https://www.google.com'
        new_title = 'Good Title'

        post '/api/v1/links', params: { link: { url: new_url, title: new_title } }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response['errors']).to be_an(Array)
        expect(parsed_response['errors'].length).to be(1)
        expect(parsed_response['errors'].first).to eq('Must be logged in to create a link')
      end
    end
  end
end
