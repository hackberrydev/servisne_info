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

  private

  def downcase_towns
    self.towns = towns.map(&:downcase) if towns.present?
  end
end
