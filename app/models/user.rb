class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  paginates_per 50

  validates :streets, presence: true

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
    self.towns = towns.map(&:downcase) if towns.present?
  end
end
