require 'test_helper'

class CommentVotesControllerTest < ActionController::TestCase
  #setup do
    #@vote = votes(:one)
  #end

  fixtures :comments
  fixtures :comment_votes

  test "should not vote his own comments" do
    session[:user_id] = comments(:comment1).user_id
    get :new, :id=>comments(:comment1).id

    assert_redirected_to :controller=>"posts", :action=>"index"
  end


end
