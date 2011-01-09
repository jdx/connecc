Connecc::Application.routes.draw do

  # note: NOTHING can be a 5 character route with this implementation, we can change that later if we need to

  get ":code" => "cards#show", :as => "card", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/contact_request" => "cards#contact_request", :as => "contact_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/notification_request" => "cards#notification_request", :as => "notification_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  put ":code/edit" => "cards#update", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/edit" => "cards#edit", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }

  devise_for :users do
    get "login", :to => "devise/sessions#new", :path => 'log_in'
    post "login", :to => "devise/sessions#create", :path => 'log_in'
    get "logout", :to => "devise/sessions#destroy", :path => 'log_out'
    get "account/password/forgot", :to => "devise/passwords#new"
    post "account/password/forgot", :to => "devise/passwords#create"
    get "account/password/change", :to => "devise/passwords#edit"
    put "account/password/change", :to => "devise/passwords#update"
  end

  namespace "admin", :path => "administration" do
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
  get "orders/:activation_string" => "orders#activate", :as => :order_activate

  get "tour" => "home#tour"
  get "privacy_policy" => "home#privacy_policy"
  get "about_us" => "home#about_us"
  get "faq" => "home#faq"

  post "google_checkout_api/callback" => "google_checkout_api#callback"

  root :to => "home#home"
end
