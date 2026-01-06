Rails.application.routes.draw do
  root "products#index"

  devise_for :users

  resources :products do
    collection do
      get :my
    end

    member do
      delete "images/:image_id", to: "products#remove_image", as: :remove_image
    end
  end
end
