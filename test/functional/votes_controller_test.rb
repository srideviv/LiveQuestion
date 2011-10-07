require 'test_helper'

class VotesControllerTest < ActionController::TestCase

  #setup do
    #@vote = votes(:one)
  #end

  fixtures :posts

  test "should not vote own post" do
    session[:user_id] = posts(:post1).user_id
    get :new, :id=>posts(:post1).id

    assert_redirected_to(:controller=>:posts, :action=>:index)
  end


end
