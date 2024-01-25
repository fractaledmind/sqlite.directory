require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "shouldn't define index" do
    get users_url
    assert_response :not_found
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "new@email.com" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "shouldn't define edit" do
    assert_raises NoMethodError do
      get edit_user_url(@user)
    end
  end

  test "shouldn't define update user" do
    patch user_url(@user), params: { user: { avatar_url: @user.avatar_url, email: @user.email } }
    assert_response :not_found
  end

  test "shouldn't define destroy" do
    assert_difference("User.count", 0) do
      delete user_url(@user)
    end

    assert_response :not_found
  end
end
