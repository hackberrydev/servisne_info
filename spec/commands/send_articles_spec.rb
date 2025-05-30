require "rails_helper"

RSpec.describe SendArticles do
  before do
    @user = FactoryBot.create(:user, streets: "Banovic Strahinje", towns: ["novi sad"])

    @article1 = FactoryBot.create(:article, title: "No water in Banovic Strahinje", town: "novi sad", pending: true)
    @article2 = FactoryBot.create(:article, title: "No water in Narodnog fronta", town: "novi sad", pending: true)
    @article3 = FactoryBot.create(:article, title: "No water in Banovic Strahinje", town: "novi sad", pending: false)
  end

  it "sends matching pending articles to users" do
    mail = double
    expect(UserMailer).to receive(:new_articles).with(@user, [@article1]).and_return(mail)
    expect(mail).to receive(:deliver_now)

    send_articles = SendArticles.new

    send_articles.call
  end

  it "doesn't send articles where the down doesn't match to users" do
    @user.update!(towns: ["belgrade"])

    expect(UserMailer).not_to receive(:new_articles)

    SendArticles.new.call
  end

  it "marks articles as done" do
    send_articles = SendArticles.new

    send_articles.call

    expect(@article1.reload.pending?).to be_falsy
    expect(@article2.reload.pending?).to be_falsy
  end

  it "doesn't send email if there are no articles" do
    send_articles = SendArticles.new
    @user.update!(streets: "1300 kaplara")

    expect(UserMailer).not_to receive(:new_articles)

    send_articles.call
  end

  it "creates event" do
    send_articles = SendArticles.new

    send_articles.call

    event = Event.last

    expect(event.message).to eq("Sent email to user #{@user.email}")
  end
end
