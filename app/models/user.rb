class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  AVAILABLE_TOWNS = [
    "kać",
    "ledinci",
    "novi sad",
    "rakovac"
  ].freeze

  paginates_per 50

  validates :streets, presence: true
  validates :towns, inclusion: {in: AVAILABLE_TOWNS}

  before_validation :downcase_towns

  scope :recent, -> { where("created_at > ?", 24.hours.ago) }

  def make_admin
    update!(admin: true)
  end

  def streets_array
    streets.split(",").map(&:strip)
  end

  def search_pending_articles
    streets_array
      .flat_map { Article.pending.where(town: towns).search_by_street(it) }
      .uniq
  end

  private

  def downcase_towns
    return if towns.blank?

    self.towns = towns.map(&:downcase).compact_blank
  end
end
