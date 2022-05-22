module Posts
  class RepliesController < ApplicationController
    before_action :authenticate_user!

    before_action :find_post!

    def new
      @reply = Reply.new 
    end

    def create
      ::Replies::CreateCommand.call(reply_params, current_context) do
        on(:success) do |reply|
          redirect_to reply.post
        end
        on(:redirect) do |url|
          redirect_to url
        end
      end
    end

    private

    def find_post!
      @post = Post.find(params[:post_id])
    end

    def reply_params
      params.require(:reply).permit(:content).tap do |permitted_params|
        permitted_params[:post_id] = @post.id
      end
    end
  end
end
