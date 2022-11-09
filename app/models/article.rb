class Article < ApplicationRecord
  include PgSearch::Model

  validates :title, :content, :presence => true
  validates :url, :presence => true, :uniqueness => true

  pg_search_scope :search_by_street, :against => [:title, :content], :ignoring => :accents

  scope :recent, -> { order(:created_at => :desc).limit(10) }
  scope :pending, -> { where(:pending => true) }

  def self.mark_all_done
    update_all(:pending => false)
  end
end
