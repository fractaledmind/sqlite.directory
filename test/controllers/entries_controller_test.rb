require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  class UnauthenticatedTest < EntriesControllerTest
    setup do
      @entry = entries(:one)
    end

    test "should get index" do
      get entries_url

      assert_response :success
    end

    test "shouldn't permit new" do
      get new_entry_url

      assert_redirected_to root_url
    end

    test "shouldn't permit create" do
      assert_difference("Entry.count", 0) do
        post entries_url, params: { entry: { name: @entry.name, url: @entry.url, uses: @entry.uses, host: @entry.host, operating_system: @entry.operating_system, repository_url: @entry.repository_url } }
      end

      assert_redirected_to root_url
    end

    test "should show entry" do
      get entry_url(@entry)

      assert_response :success
    end

    test "shouldn't permit edit" do
      get edit_entry_url(@entry)

      assert_redirected_to root_url
    end

    test "shouldn't permit update" do
      patch entry_url(@entry), params: { entry: { host: @entry.host, name: @entry.name, operating_system: @entry.operating_system, repository_url: @entry.repository_url, url: @entry.url, uses: @entry.uses } }

      assert_redirected_to root_url
    end

    test "shouldn't permit destroy" do
      assert_difference("Entry.count", 0) do
        delete entry_url(@entry)
      end

      assert_redirected_to root_url
    end
  end

  class AuthenticatedTest < EntriesControllerTest
    setup do
      @entry = entries(:one)
      authenticate(user: users(:one))
    end

    test "should get index" do
      get entries_url
      assert_response :success
    end

    test "should get new" do
      get new_entry_url
      assert_response :success
    end

    test "should create entry" do
      assert_difference("Entry.count", 1) do
        post entries_url, params: { entry: { name: @entry.name, url: @entry.url, uses: @entry.uses, host: @entry.host, operating_system: @entry.operating_system, repository_url: @entry.repository_url } }
      end

      assert_redirected_to entries_url
    end

    test "should show entry" do
      get entry_url(@entry)
      assert_response :success
    end

    test "should get edit" do
      get edit_entry_url(@entry)
      assert_response :success
    end

    test "should update entry" do
      patch entry_url(@entry), params: { entry: { host: @entry.host, name: @entry.name, operating_system: @entry.operating_system, repository_url: @entry.repository_url, url: @entry.url, uses: @entry.uses } }
      assert_redirected_to entries_url
    end

    test "should destroy entry" do
      assert_difference("Entry.count", -1) do
        delete entry_url(@entry)
      end

      assert_redirected_to entries_url
    end
  end
end
