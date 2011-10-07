require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  fixtures "users"
  #setup do
    #@user = user(:sri)
  #end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_no_difference('User.count') do
      post :create, :@user=>{:uname=>"example", :password=>"fixpassword1"}
    end

  end


  test "should show user" do
    get :show, :id=> users(:sri).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id=> users(:sri).to_param
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:sri).to_param
    end

    assert_redirected_to users_path
  end
end
