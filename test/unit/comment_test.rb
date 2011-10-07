require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  fixtures  :comments

  test "the truth" do
     assert true
  end

  #test the presence of reply
  test "Comment invalid with empty reply" do
    comment = Comment.new
    assert !comment.valid?
  end

  #test if the there is a unique post & userid
   test "uniqueness of comment and userid" do
     comment = Comment.new(:id => comments(:comment1).id,
                   :reply => "this is a test reply",
                   :user_id => comments(:comment1).user_id)
     assert comment.save
   end

end
