class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  validates :first_name, :last_name, :affiliation, presence: true
  validates :username, :email, uniqueness: true, presence: true
  auto_strip_attributes :first_name, :last_name, :username, :squish => true

  before_save :capitalize_names


  def capitalize_names
    self.first_name = self.first_name.to_s.capitalize.titleize
    self.last_name = self.last_name.to_s.capitalize.titleize
  end

  def to_s
    first_name + " " + last_name
  end

end
