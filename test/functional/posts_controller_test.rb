require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  fixtures "users"
  fixtures "posts"

  #setup do
    #@post = post(:post1)
  #end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should not get new" do

    session[:current_user_id] = nil #for a non-existing user
    get :new
    assert_redirected_to :controller=>"posts" #path correct?


  end

  test "should create post" do   #only for logged in users
    session[:user_id] = 5
    assert_difference('Post.count') do
      post :create, :post => {:question=>"this post1", :user_id=>5}
    end

  end


  test "should destroy post" do
    session[:user_id] = posts(:post1).user_id
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:post1).id
    end

  end

  #Implement this
  test "should allow search post by user" do
    session[:user_id] = nil
    get :search, :search_input => "sri"
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should allow search post by post" do
    session[:user_id] = nil
    get :search, :search_input => "sri"
    assert_response :success
    assert_not_nil assigns(:posts)
  end


  test "should show post" do
    get :show, :id=> posts(:post1).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id=> posts(:post1).to_param
    assert_response :success
  end

  test "should update post" do
    put :update, :id=> posts(:post1).to_param, :question => posts(:post1).attributes
    assert_redirected_to post_path(assigns(:post))
  end



end
