class Article < ApplicationRecord
  include PgSearch
  
  validates :title, :content, :presence => true
  validates :url, :presence => true, :uniqueness => true
  
  pg_search_scope :search_by_street, :against => [:title, :content], :ignoring => :accents
  
  scope :recent, -> { order(:created_at => :desc).limit(10) }
end
