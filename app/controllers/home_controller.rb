class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @products = Product.order(created_at: :desc)
  end
end
