# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def new_articles
    UserMailer.new_articles(User.first, Article.limit(5))
  end
end
