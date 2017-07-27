require 'rails_helper'

RSpec.describe Link do

  it 'has a valid factory' do
    expect(build(:link)).to be_valid
  end

  let(:link) { build(:link) }

  describe 'attributes' do
    it { expect(link).to respond_to(:url) }
    it { expect(link).to respond_to(:title) }
    it { expect(link).to respond_to(:read) }
  end

  describe 'ActiveModel validations' do
    it { expect(link).to validate_presence_of(:url) }
    it { expect(link).to validate_presence_of(:title) }
    it { expect(link).to allow_value('http://www.google.com').for(:url) }
    it { expect(link).to_not allow_value('badurl.com').for(:url) }
  end

  describe 'ActiveRecord associations' do
    it { expect(link).to belong_to(:user) }
  end
end
