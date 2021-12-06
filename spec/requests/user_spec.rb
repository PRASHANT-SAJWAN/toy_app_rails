require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "signup" do
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
        # p response.code
        expect(user_data["user"]["email"]).to(eq(@user_params[:email]))
        expect(user_data["post"]).to(eq([]))
      end

      it 'display all users' do
        # create users
        User.create(@user_params)
        # route to get all users
        get '/api/v1/users/'
        user_data = JSON.parse(response.body)
        # p user_data
      end

      it 'login failcase' do
        @user = User.create(@user_params)
        post '/api/v1/login', :params=> {"email"=>@user.email, "password"=>@user.password}
        follow_up = response.headers["Location"]
        get "/api/v1/#{follow_up}"
        user_data = JSON.parse(response.body)
        # p user_data

        expect(user_data["email"]).to(match_array(@user))
      end
    end
  end
end
