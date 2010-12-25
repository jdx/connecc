Connecc::Application.routes.draw do

  devise_for :users do
    get "login", :to => "devise/sessions#new"
    post "login", :to => "devise/sessions#create"
    get "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "devise/registrations#new"
    post "signup", :to => "devise/registrations#create"
  end

  namespace "admin" do
    resources :orders
    resources :private_beta_signups
    resources :users
    get "/" => "admin#dashboard"
  end

  resource :trial_order, :only => [ :create, :new ], :path_names => { :new => "place" }

  get "/dashboard" => "home#dashboard"
  get "/tour" => "home#tour"
  root :to => "private_beta#splash"
end
