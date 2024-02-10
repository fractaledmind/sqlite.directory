class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user

  def session=(session)
    super
    self.user = session.user
  end
end
