class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to:user
  has_many :comment_votes

  validates_presence_of :reply

  def self.destroyCascade(comment)
    comment.destroy
  end
end
