class Article < ApplicationRecord
  validates :url, :title, :content, :presence => true
end
