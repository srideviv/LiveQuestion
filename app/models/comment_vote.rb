class CommentVote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  def self.destroyCascade(commentvote)
    commentvote.destroy
  end
end
