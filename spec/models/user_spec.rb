require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user_params = {
      email: 'test@test.com',
      name: 'testuser',
      password: 'userpass'
    }
  end
  it 'has username password and email' do
    user = User.new(@user_params)
    expect(user.valid?).to(eq(true))
    user.save!

    user = User.new(@user_params)
    expect(user.valid?).to(eq(false))

    expect(user.errors.messages[:email]).to(eq(["has already been taken"]))
  end
end
