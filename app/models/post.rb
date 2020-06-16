class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  auto_strip_attributes :title, :squish => true
  validates :title, :body, presence: true

end
