require 'rails_helper'

RSpec.describe "Users", type: :request do
  context "signup" do
    before :each do
      @user_params = {
        email: 'test@test.com',
        name: 'testuser',
        password: 'userpass'
      }
    end

    it "create user" do
      post "/api/v1/signup", :params => @user_params
      follow_up = response.headers["Location"]
      get "/api/v1/#{follow_up}"
      user_data = JSON.parse(response.body)
      # p response.status

      expect(user_data["user"]["email"]).to(eq(@user_params[:email]))
      expect(user_data["post"]).to(eq([]))
    end

    it 'display all users' do
      # create users
      # User.create(@user_params)
      create(:user)
      # route to get all users
      get '/api/v1/users/'

      expect(response.status).to(eq(200))
    end

    it 'login success' do
      # @user = User.create(@user_params)
      @user = create(:user)
      post '/api/v1/login', :params=> {"email"=>@user.email, "password"=>@user.password}
      expect(response.status).to(eq(302))

      follow_up = response.headers["Location"]
      get "/api/v1/#{follow_up}"

      expect(response.status).to(eq(200))
    end
  end
end
