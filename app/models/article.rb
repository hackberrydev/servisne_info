class Article < ApplicationRecord
  validates :title, :content, :presence => true
  validates :url, :presence => true, :uniqueness => true
  
  scope :recent, -> { order(:created_at => :desc).limit(10) }
end
