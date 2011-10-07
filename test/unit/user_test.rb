require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users
  test "the truth" do
     assert true
  end

  #validate the presence of username
  test "invalid or no username" do
    user = User.new
    assert !user.valid?
  end

  #test the uniqueness of username
  test "username already present - not unique" do
    user = User.new
    user.uname = users(:sri).uname
    user.password = "fixpassword1"
    user.id = (users(:sri).id + 1)
    assert !user.valid?
    user.errors[:uname]= ["has already been taken"]
    #assert_equal("[has already been taken]", user.errors[:uname])
    #user.errors[:uname].should_equal "is already taken"
 end

  #test the encryption of password
  test "password is encrypted" do
   user = User.new
   user.uname = "uname2"
   user.password = "password2"
   user.save
   assert_not_equal(user.password, user.hashed_password, "password has to be encrypted" )
 end

  #test user authentication
  test "authenticate" do
    user = User.new
    user.uname = "uname1"
    user.password = "password1"
    user.save
    assert_not_nil user.authenticate("uname1", "password1")
    #assert_not_nil User.authenticate(user.uname, user.password)
    assert_nil user.authenticate(user.uname, "random")
  end

end
