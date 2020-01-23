class Favourite < ApplicationRecord
  validates_presence_of :user_id, :provider_id

  belongs_to :user
end
