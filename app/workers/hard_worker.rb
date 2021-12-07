class HardWorker
  include Sidekiq::Worker

  def perform(*params)
    # Do something
    params = params[0]
    # @user = User.find (params["user_id"])
    @post = Post.create(params)
    p @post
  end
end
