class SendArticles
  def call
    send_emails_to_users
    Article.mark_all_done
  end
  
  private
  
  def send_emails_to_users
    User.find_each do |user|
      articles = user_articles(user)
      UserMailer.new_articles(user, articles).deliver_now
    end
  end
  
  def user_articles(user)
    user.streets_array
        .flat_map { |street| Article.pending.search_by_street(street) }
        .uniq
  end
end

