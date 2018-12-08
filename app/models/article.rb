class Article < ApplicationRecord
  validates :url, :presence => true
end
