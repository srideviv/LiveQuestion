require 'test_helper'

class LoginControllerTest < ActionController::TestCase

  fixtures :users
  test "the truth" do
    assert true
  end

  test "redirect to login" do
    get :index
    assert_response :success

  end

  test "login success" do
    user = users(:sri)
    post :login, :uname => users(:sri).uname, :password=> "fixpassword1"
       assert_redirected_to(:controller=>"posts", :action => "index")

    post :login, :uname => users(:sri).uname, :password=> "password1"
    assert_redirected_to(:controller=>"login", :action => "index")

  end
end
