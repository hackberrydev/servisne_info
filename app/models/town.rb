class Town
  def self.new_towns
    Article.distinct.pluck(:town).sort - User::AVAILABLE_TOWNS
  end
end
