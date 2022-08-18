require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest

  # 1. Go to sign up page and check for form
  #   check status of petition and if form exists
  # 2. Post to create user and check if it was created
  #   check for database change
  #   check for redirect status and check if we are on user page

  test "sign up successfully" do
    # check for successful access to sign up page
    get '/signup'
    assert_response :success
    assert_select 'h1.text-center', text: 'Sign up for Alpha Blog'

    # check for post to create user and database change
    assert_difference 'User.count', 1 do
      post '/users', params: {user: {username: 'amigo', password: 'amigo', email: 'amigo@amigo.com'}}
    end

    # check for successfull redirect to article listing page
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1.text-center.mt-4', text: 'Article Index'
  end

end
