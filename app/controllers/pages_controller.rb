class PagesController < ApplicationController
  def index
    @articles = Article.recent
  end
end
