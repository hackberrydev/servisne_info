class AdminMailer < ApplicationMailer
  def daily_report(admin_email, events)
    @events = events
    
    mail(:to => admin_email, :subject => "Izveštaj za #{Date.today}")
  end
end