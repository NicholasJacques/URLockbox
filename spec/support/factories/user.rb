FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'

    factory :user_with_links do
      links { create_list(:link, 2) }
    end
  end

  sequence :email do |n|
    "test#{n}@test.com"
  end
end
