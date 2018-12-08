class PagesController < ApplicationController
  def index
    @articles = Article.all
  end
end
