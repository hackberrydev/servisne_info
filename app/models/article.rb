class Article < ApplicationRecord
  validates :url, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true
end
