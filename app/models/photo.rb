class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :likes
  has_many :comments 
end
