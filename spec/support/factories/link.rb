FactoryGirl.define do
  factory :link do
    title
    url
  end

  sequence :title do |n|
    "Title #{n}"
  end

  sequence :url do |n|
    "http://www.link#{n}.com"
  end

end