require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has username password and email' do
    user = build(:user, email:"same")
    expect(user.valid?).to(eq(true))
    user.save!

    user = build(:user, email:"same")
    expect(user.valid?).to(eq(false))

    expect(user.errors.messages[:email]).to(eq(["has already been taken"]))
  end
end
