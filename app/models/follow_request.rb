class FollowRequest < ApplicationRecord
  belongs_to :recipient
  belongs_to :sender
end
