require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  #setup do
    #@comment = comments(:one)
  #end
  fixtures "comments"
  fixtures "posts"
  fixtures "users"

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should not get new" do
    session[:user_id] = nil #for a non-existing user
    get :new
    assert_redirected_to :controller=>"posts", :action=>"index" #path c


  end

  test "should create comment" do   #only for logged in users
    session[:user_id] = 5
    assert_difference('Comment.count') do
      post :create, :comment => {:reply=>"this comment1", :user_id=>5}
    end

  end



  test "should show comment" do
    get :show, :id=> comments(:comment1).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id=> comments(:comment1).to_param
    assert_response :success
  end

  test "should update comment" do
    put :update, :id=> comments(:comment1).to_param, :comment=> comments(:comment1).attributes
    assert_redirected_to comment_path(assigns(:comment))
  end

end
