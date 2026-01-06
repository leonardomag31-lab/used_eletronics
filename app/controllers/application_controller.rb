class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
  end
end
