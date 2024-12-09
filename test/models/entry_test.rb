require "test_helper"

class EntryTest < ActiveSupport::TestCase
  test "belongs to user" do
    session = Entry.new(user: nil)
    session.valid?
    assert session.errors.of_kind? :user, :blank
  end

  test "name cannot be nil" do
    user = Entry.new(name: nil)
    user.valid?
    assert user.errors.of_kind? :name, :blank
  end

  test "url cannot be nil" do
    user = Entry.new(url: nil)
    user.valid?
    assert user.errors.of_kind? :url, :blank
  end

  test "url must be http url" do
    user = Entry.new(url: "foo")
    user.valid?
    assert user.errors.of_kind? :url, :invalid_http_url
  end

  test "uses must be at least one" do
    user = Entry.new(uses: [])
    user.valid?
    assert user.errors.of_kind? :uses, :at_least_one
  end
end
