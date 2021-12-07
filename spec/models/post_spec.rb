require 'rails_helper'

RSpec.describe Post, type: :model do
  # before :each do
  #   @user_params = {
  #     email: 'test@test.com',
  #     name: 'testuser',
  #     password: 'userpass'
  #   }
  #   @post_params = {
  #     content: "test-content",
  #     user_id: 1
  #   }
  # end

  it 'check post belongs to user' do
    # user = User.create(@user_params)
    # post = Post.create(@post_params)

    user = create(:user)
    post1 = create(:post, user_id: user.id)
    post2 = create(:post, user_id: user.id)
    post3 = create(:post, user_id: user.id)

    expect(user.post).to(match_array([post1, post2, post3]))
  end
end
