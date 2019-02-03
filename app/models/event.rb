class Event < ApplicationRecord
  scope :recent, -> { where("created_at > ?", 24.hours.ago) }
end
