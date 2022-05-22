class Moderation::Log < ApplicationRecord
  belongs_to :ip_address
  belongs_to :user_agent
  belongs_to :user
  belongs_to :thing, polymorphic: true, optional: true
end
