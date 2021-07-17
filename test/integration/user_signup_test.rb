require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test 'sign up a user' do
    get singup_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        username: 'cchicas',
        email: 'carloschicas@yahoo.com',
        password: 'password'
      } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Welcome to Alpha Blog cchicas', response.body
  end
end
