require "test_helper"

class SessionTest < ActiveSupport::TestCase
  test "belongs to user" do
    session = Session.new(user: nil)
    session.valid?
    assert session.errors.of_kind? :user, :blank
  end
end
