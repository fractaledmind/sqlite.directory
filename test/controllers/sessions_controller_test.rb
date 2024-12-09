require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  class UnauthenticatedTest < SessionsControllerTest
    setup do
      @session = sessions(:one)
    end

    test "shouldn't define index" do
      assert_raises NameError do
        get sessions_url
      end
    end

    test "shouldn't define new" do
      assert_raises NameError do
        get new_session_url
      end
    end

    test "shouldn't define create" do
      assert_raises NameError do
        post sessions_url, params: { session: { ip_address: @session.ip_address, user_agent: @session.user_agent, user_id: @session.user_id } }
      end
    end

    test "shouldn't define show" do
      get session_url(@session)
      assert_response :not_found
    end

    test "shouldn't define edit" do
      assert_raises NoMethodError do
        get edit_session_url(@session)
      end
    end

    test "shouldn't define update" do
      patch session_url(@session)
      assert_response :not_found
    end

    test "shouldn't permit destroy" do
      assert_difference("Session.count", 0) do
        delete session_url(@session)
      end

      assert_redirected_to root_url
    end
  end

  class AuthenticatedTest < SessionsControllerTest
    setup do
      @session = sessions(:one)
      authenticate(user: @session.user)
    end

    test "shouldn't define index" do
      assert_raises NameError do
        get sessions_url
      end
    end

    test "shouldn't define new" do
      assert_raises NameError do
        get new_session_url
      end
    end

    test "shouldn't define create" do
      assert_raises NameError do
        post sessions_url, params: { session: { ip_address: @session.ip_address, user_agent: @session.user_agent, user_id: @session.user_id } }
      end
    end

    test "shouldn't define show" do
      get session_url(@session)
      assert_response :not_found
    end

    test "shouldn't define edit" do
      assert_raises NoMethodError do
        get edit_session_url(@session)
      end
    end

    test "shouldn't define update" do
      patch session_url(@session)
      assert_response :not_found
    end

    test "shouldn't permit destroy" do
      assert_difference("Session.count", -1) do
        delete session_url(@session)
      end

      assert_redirected_to root_url
    end
  end
end
