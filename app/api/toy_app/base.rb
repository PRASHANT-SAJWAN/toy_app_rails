module ToyApp
  class Base < Grape::API
    mount ToyApp::V1::Users
  end
end
