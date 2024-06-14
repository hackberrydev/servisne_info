# frozen_string_literal: true

class Article < ApplicationRecord
  include PgSearch::Model

  validates :title, :content, presence: true
  validates :url, presence: true, uniqueness: true

  pg_search_scope :search_by_street, against: [:title, :content], ignoring: :accents

  scope :recent, -> { order(created_at: :desc).limit(10) }
  scope :pending, -> { where(pending: true) }

  def self.mark_all_done
    update_all(pending: false)
  end

  def url=(value)
    super

    self.external_id = extract_external_id
  end

  def extract_external_id
    return if url.blank?

    url.split("/")[6]
  end
end
