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
        get 'cards', :defaults => { :format => :pdf }
      end
    end
    resources :users
    get "cards/cutting_sheet" => "cards#cutting_sheet", :defaults => { :format => :pdf }
    get "cards/perforating_sheet" => "cards#perforating_sheet", :defaults => { :format => :pdf }
    get "/" => "admin#dashboard"
  end

  resource :trial_order, :only => [ :create, :new ], :path_names => { :new => "place" }
  resources :orders

  get "tour" => "home#tour"
  get "privacy_policy" => "home#privacy_policy"
  get "about_us" => "home#about_us"
  get "faq" => "home#faq"

  post "google_checkout_api/callback" => "google_checkout_api#callback"

  get ":code" => "cards#show", :as => "card"
  post ":code/contact_request" => "cards#contact_request", :as => "contact_request"
  post ":code/notification_request" => "cards#notification_request", :as => "notification_request"
  put ":code/edit" => "cards#update", :as => "card_edit"
  get ":code/edit" => "cards#edit", :as => "card_edit"
  root :to => "home#home"
end
