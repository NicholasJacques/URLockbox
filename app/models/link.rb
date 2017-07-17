class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true
end
