module Pages
  class HelpController < ApplicationController
    def rate_limited
      render plain: "You have been rate-limited."
    end

    def spam
      render plain: "We detected spam and reset your password."
    end
  end
end
