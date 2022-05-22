module Replies
  class CreateCommand < ApplicationCommand
    include Moderation::WithActivity
    include ContentCreation

    private

    def content_type
      Reply
    end

    def create_content
      Reply.create!(user: @context.user, content: @params[:content], post_id: @params[:post_id])
    end
  end
end
