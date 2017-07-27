class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true,
                  url: { message: 'is invalid', allow_blank: true }
  validates :title, presence: true
end
