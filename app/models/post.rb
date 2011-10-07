class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  has_many :votes,
  :order => "created_at"

  validates_presence_of :question

  def self.destroyCascade(post)
    post.destroy
  end
end
