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
  end
end
