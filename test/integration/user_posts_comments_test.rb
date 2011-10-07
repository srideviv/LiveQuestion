require "integration_test_helper"

class UserPostsAndCommentsTestTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "the truth" do
    assert true
  end

  test "create new post before login" do
    visit "/posts"
    click_link "Post a Question"
    assert(current_path)=="/posts"
    visit "/login"
    fill_in "userId", :with=>users(:sri).uname
    fill_in "password", :with=>"fixpassword1"
    click_button "signIn"

    assert(current_path)=="/posts"
  end


  test "create new post" do
    visit "/login"
    fill_in "userId", :with=>users(:sri).uname
    fill_in "password", :with=>"fixpassword1"
    click_button "signIn"
    visit "/posts"
    click_link "Post a Question"
    fill_in "post_question", :with=>"This is my post"
    click_button "Create Post"
    assert(current_path)=="/posts/"
    click_link "comment"
     fill_in "Reply", :with=>"This is my comment"
    click_button "Create Comment"
    assert page.has_content?("This is my comment")

end


  test "search for posts" do
    visit "/posts"
    fill_in "search_input", :with=> "This is my post"

    click_button "post"
    assert page.has_content? ("This is my post")
  end

  test "search for users" do
    visit "/posts"
    fill_in "search_input", :with=> "sri"

    click_button "user"
    assert page.has_content? ("sri")
  end




  test "create new comment" do
    visit "/login"
    fill_in "userId", :with=>users(:sri).uname
    fill_in "password", :with=>"fixpassword1"
    click_button "Sign in"
    visit "/posts"
    click_on "comment"

    fill_in "Reply", :with=>"This is my comment"
    click_button "Create Comment"
    assert page.has_content?("This is my comment")
  end



end
