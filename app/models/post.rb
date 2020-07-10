class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :likes, dependent: :destroy

  self.per_page = 15


  auto_strip_attributes :title, :squish => true
  validates :title, :body, presence: true

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.approved_public(page)
    Post.where(approved:true, public:true).paginate(:page => page).order('id DESC')
  end

  def self.approved_all(page)
    Post.where(approved:true).paginate(:page => page).order('id DESC')
  end

  def self.unapproved(page)
    Post.where(approved:false).paginate(:page => page).order('id DESC')
  end

  def self.user_all(page,user)
    Post.where(user_id:user.id).paginate(:page => page).order('id DESC')
  end

end
