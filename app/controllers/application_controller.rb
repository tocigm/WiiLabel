class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def menu
    @menu = ["1","2"]
  end

end
