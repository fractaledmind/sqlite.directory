require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = sessions(:one)
  end

  test "shouldn't define index" do
    get sessions_url
    assert_response :not_found
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    assert_difference("Session.count") do
      post sessions_url, params: { session: { ip_address: @session.ip_address, user_agent: @session.user_agent, user_id: @session.user_id } }
    end

    assert_redirected_to user_url(Session.last.user)
  end

  test "shouldn't define show" do
    assert_raises NoMethodError do
      get session_url(@session)
    end
  end

  test "shouldn't define edit" do
    assert_raises NoMethodError do
      get edit_session_url(@session)
    end
  end

  test "should update session" do
    assert_raises NoMethodError do
      patch session_url(@session)
    end
  end

  test "should destroy session" do
    assert_raises NoMethodError do
      delete session_url(@session)
    end
  end
end
