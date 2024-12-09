require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "github_username cannot be nil" do
    user = User.new(github_username: nil)
    user.valid?
    assert user.errors.of_kind? :github_username, :blank
  end

  test "github_uid cannot be nil" do
    user = User.new(github_uid: nil)
    user.valid?
    assert user.errors.of_kind? :github_uid, :blank
  end

  test "github_uid must be unique" do
    one = users(:one)
    user = User.new(github_uid: one.github_uid)
    user.valid?
    assert user.errors.of_kind? :github_uid, :taken
  end
end
