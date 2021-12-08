require 'rails_helper'

RSpec.describe "Users", type: :request do
  before :each do
    @user_params = {
      email: 'test@test.com',
      name: 'testuser',
      password: 'userpass'
    }
  end

  it "create user" do
    post "/api/v1/signup", :params => @user_params
    # byebug
    follow_up = response.headers["Location"]
    get "/api/v1/#{follow_up}"
    user_data = JSON.parse(response.body)

    expect(user_data["user"]["email"]).to(eq(@user_params[:email]))
    expect(user_data["post"]).to(eq([]))
  end

  it 'display all users' do
    # create users
    create(:user)
    create(:user)
    create(:user)
    # route to get all users
    get '/api/v1/users/'

    expect(response.status).to(eq(200))
    expect(JSON.parse(response.body).size).to(eq(3))
  end

  it 'login success' do
    @user = create(:user)
    post '/api/v1/login', :params=> {"email"=>@user.email, "password"=>@user.password}
    expect(response.status).to(eq(302))

    follow_up = response.headers["Location"]
    get "/api/v1/#{follow_up}"

    expect(response.status).to(eq(200))
  end

  it 'create a post' do
    @user = create(:user)
    create(:post, user_id: @user.id)

    expect(@user.post.count).to(eq(1))
  end

  it 'update test' do
    @user = create(:user)
    params = {
      name: "updated user",
      email: 'test@test.com',
      password: 'userpass'
    }
    @user.update(params)
    expect(@user.name).to(eq(params[:name]))
  end
end
