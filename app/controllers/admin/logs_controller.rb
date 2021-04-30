class Admin::LogsController < Admin::ApplicationController
  def index
    @log = File.open("log/url-scrapper.log", "r")
  end
end
