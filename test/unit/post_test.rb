require 'test_helper'

class PostTest < ActiveSupport::TestCase

  fixtures  :posts

  test "the truth" do
     assert true
  end

  #test the presence of question for the post
  test "Post invalid with empty question" do
    post = Post.new
    assert !post.valid?
  end

   #test if the there is a unique post & userid
   test "uniqueness of post and userid" do
     post = Post.new(:id => posts(:post1).id,
                   :question => "this is a test question",
                   :user_id => posts(:post1).user_id)
     assert post.save
   end

end
