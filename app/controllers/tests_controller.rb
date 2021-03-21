class TestsController < ApplicationController
  def show

  end

  def update
    @message = params[:test][:message]
    render :show
  end
end
