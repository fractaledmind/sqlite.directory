require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  class UnauthenticatedTest < UsersControllerTest
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

    test "should show user" do
      get user_url(@user)
      assert_response :ok
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

  class AuthenticatedTest < UsersControllerTest
    setup do
      @user = users(:one)
      authenticate(user: @user)
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

    test "should show user" do
      get user_url(@user)
      assert_response :ok
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
end
