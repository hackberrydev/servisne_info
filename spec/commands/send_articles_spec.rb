require "rails_helper"

RSpec.describe SendArticles do
  before do
    @user = FactoryBot.create(:user, :streets => "Banovic Strahinje")
    
    @article1 = FactoryBot.create(:article, :title => "No water in Banovic Strahinje", :pending => true)
    @article2 = FactoryBot.create(:article, :title => "No water in Narodnog fronta", :pending => true)
    @article3 = FactoryBot.create(:article, :title => "No water in Banovic Strahinje", :pending => false)
  end
  
  it "sends matching pending articles to users" do
    mail = double
    expect(UserMailer).to receive(:new_articles).with(@user, [@article1]).and_return(mail)
    expect(mail).to receive(:deliver_now)
    
    send_articles = SendArticles.new
    
    send_articles.call
  end
  
  it "marks articles as done" do
    send_articles = SendArticles.new
    
    send_articles.call
    
    expect(@article1.reload.pending?).to be_falsy
    expect(@article2.reload.pending?).to be_falsy
  end
end