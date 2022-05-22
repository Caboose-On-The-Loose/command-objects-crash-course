module Posts
  class CreateCommand < ApplicationCommand
    include Moderation::WithActivity
    include ContentCreation

    private

    def content_type
      Post
    end

    def create_content
      Post.create!(user: @context.user, subject: @params[:subject], content: @params[:content])
    end
  end
end
