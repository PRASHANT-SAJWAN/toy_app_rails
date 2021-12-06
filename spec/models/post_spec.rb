require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user_params = {
      email: 'test@test.com',
      name: 'testuser',
      password: 'userpass'
    }
  end

  it 'check post belongs to user' do
    user = User.create(@user_params)
    post = Post.create(content: "test-content", user_id: 1)

    expect(user.post).to(match_array(post))
  end
end
