class Article < ApplicationRecord
  validates :url, :title, :content, :presence => true
  
  scope :recent, -> { order(:created_at => :desc).limit(10) }
end
