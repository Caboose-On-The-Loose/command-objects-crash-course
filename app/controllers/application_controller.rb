class ApplicationController < ActionController::Base
  private

  def current_context
    @current_context ||= User::Context.new(current_user).for(request)
  end
end
