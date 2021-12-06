module ToyApp
  module V1
    class Users < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      desc 'Returns list of all users'
      resource :users do
        get do
          present User.all.map {|user| {:user=> user, :post=> user.post}}
        end

        desc 'return a user'
        route_param :user_id do
          get do
            @user = User.find(params[:user_id])
            present :user=>@user, :post=>@user.post
          end

          desc 'add a post'
          resource :createPost do
            post do
              # by sidekiq
              HardWorker.perform_async(params)
              present params
            end
            get do
              @user = User.find(params[:user_id])
              redirect "users/#{params[:user_id]}" if @user
            end
          end

          desc 'show all post'
          resource :posts do
            get do
              present User.find(params[:user_id]).post
            end
          end
        end
      end

      desc 'create a new user'
      resource :signup do
        post do
          @user = User.create!(params)
          # present @user
          redirect "users/#{@user.id}"
        end
      end

      desc 'login user'
      resource :login do
        post do
          @email = params[:email]
          @pass = params[:password]
          @user = User.find_by_email(@email)
          @id = @user.id

          if @user.password == @pass
            redirect "users/#{@id}"
          else
            redirect"login"
          end
        end
      end

      desc 'update user'
      resource :update do
        post do
          @user = User.find_by_email(params[:email])
          if @user.password == params[:password]
            @user.update(params)
          else
            redirect "update" if @user.password != params[:password]
          end
        end
      end
    end
  end
end
