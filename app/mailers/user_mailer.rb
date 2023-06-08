class UserMailer < ApplicationMailer
  def new_articles(user, articles)
    @articles = articles

    mail(to: user.email, subject: "Pronašli smo vesti koje vas možda zanimaju")
  end
end
