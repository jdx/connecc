Connecc::Application.routes.draw do

  get "orders/index"

  get "orders/showw"

  devise_for :users do
    get "login", :to => "devise/sessions#new"
    post "login", :to => "devise/sessions#create"
    get "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "devise/registrations#new"
    post "signup", :to => "devise/registrations#create"
    get "account/password/forgot", :to => "devise/passwords#new"
    post "account/password/forgot", :to => "devise/passwords#create"
    get "account/password/change", :to => "devise/passwords#edit"
    post "account/password/change", :to => "devise/passwords#update"
  end

  namespace "admin" do
    resources :orders
    resources :private_beta_signups
    resources :users
    get "/" => "admin#dashboard"
  end

  resource :trial_order, :only => [ :create, :new ], :path_names => { :new => "place" }
  resources :orders

  get "dashboard" => "home#dashboard"
  get "tour" => "home#tour"
  root :to => "private_beta#splash"
end
