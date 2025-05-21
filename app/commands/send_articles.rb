class SendArticles
  def call
    Rails.logger.info "Sending articles"

    send_emails_to_users
    Article.mark_all_done
  end

  private

  def send_emails_to_users
    User.find_each do |user|
      articles = user.search_pending_articles

      if articles.any?
        send_email_to_user(user, articles)
      else
        Rails.logger.info "Skipping user #{user.id}"
      end
    end
  end

  def send_email_to_user(user, articles)
    Rails.logger.info "Sending articles to user #{user.id}"
    UserMailer.new_articles(user, articles).deliver_now

    Event.create!(message: "Sent email to user #{user.email}")
  end
end
