Connecc::Application.routes.draw do

  devise_for :users do
    get "login", :to => "devise/sessions#new"
    post "login", :to => "devise/sessions#create"
    get "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "devise/registrations#new"
    post "signup", :to => "devise/registrations#create"
    get "account/password/forgot", :to => "devise/passwords#new"
    post "account/password/forgot", :to => "devise/passwords#create"
    get "account/password/change", :to => "devise/passwords#edit"
    put "account/password/change", :to => "devise/passwords#update"
    get "account/profile/edit", :to => "devise/registrations#edit"
    put "account/profile/edit", :to => "devise/registrations#update"
  end

  namespace "admin" do
    resources :orders do
      member do
        post 'generate'
        post 'ship'
      end
    end
    resources :users
    get "/" => "admin#dashboard"
  end

  resource :trial_order, :only => [ :create, :new ], :path_names => { :new => "place" }
  resources :orders

  get "dashboard" => "home#dashboard"
  get "tour" => "home#tour"
  get ":code" => "cards#show", :as => "card"
  post ":code" => "cards#contact_request", :as => "contact_request"
  put ":code/edit" => "cards#update", :as => "card_edit"
  get ":code/edit" => "cards#edit", :as => "card_edit"
  root :to => "home#home"
end
