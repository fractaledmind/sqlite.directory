require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
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
    assert_raises NoMethodError do
      get session_url(@session)
    end
  end

  test "shouldn't define edit" do
    assert_raises NoMethodError do
      get edit_session_url(@session)
    end
  end

  test "shouldn't define update" do
    assert_raises NoMethodError do
      patch session_url(@session)
    end
  end

  test "shouldn't define destroy" do
    assert_raises NoMethodError do
      delete session_url(@session)
    end
  end
end
