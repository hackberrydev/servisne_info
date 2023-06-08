# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def daily_report
    AdminMailer.daily_report("admin@example.com", Event.limit(5))
  end
end
