class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Posts::CreateCommand.call(post_params, current_context) do
      on(:success) do |post|
        redirect_to post
      end
      on(:redirect) do |url|
        redirect_to url
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @reply = Reply.new
  end

  private

  def post_params
    params.require(:post).permit(:subject, :content)
  end
end
