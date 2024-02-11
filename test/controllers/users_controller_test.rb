require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "shouldn't define index" do
    assert_raises NameError do
      get users_url
    end
  end

  test "shouldn't define new" do
    assert_raises NameError do
      get new_user_url
    end
  end

  test "shouldn't define create" do
    assert_raises NameError do
      post users_url, params: { user: { email: "new@email.com" } }
    end
  end

  test "shouldn't show user when unauthenticated" do
    get user_url(@user)
    assert_response :not_found
  end

  test "shouldn't define edit" do
    assert_raises NoMethodError do
      get edit_user_url(@user)
    end
  end

  test "shouldn't define update user" do
    assert_raises NoMethodError do
      patch user_url(@user), params: { user: { avatar_url: @user.avatar_url, email: @user.email } }
    end
  end

  test "shouldn't define destroy" do
    assert_difference("User.count", 0) do
      delete user_url(@user)
    end

    assert_response :not_found
  end
end
