class ErrorController < ApplicationController
  def index
    render :status => 404
  end
end
