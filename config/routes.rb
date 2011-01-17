Connecc::Application.routes.draw do

  devise_for :users

  resource :trial_order
  resources :google_orders
  resources :orders

  namespace "admin", :path => "administration" do
    resources :orders do
      member do
        match 'cancel'
        post 'ship'
        get 'cards', :defaults => { :format => :pdf }
        get 'envelope', :defaults => { :format => :pdf }
      end
    end
    resources :users
    get "cards/cutting_sheet" => "cards#cutting_sheet", :defaults => { :format => :pdf }
    get "cards/perforating_sheet" => "cards#perforating_sheet", :defaults => { :format => :pdf }
    get "/" => "admin#dashboard"
  end

  get "tour" => "home#tour"
  get "about_us" => "home#about_us"
  get "contact_us" => "home#contact_us"
  get "faq" => "home#faq"

  get ":code" => "cards#show", :as => "card", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/contact_request" => "cards#contact_request_get", :as => "contact_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/contact_request" => "cards#contact_request_post", :as => "contact_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/notification_request" => redirect("/%{code}"), :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/notification_request" => "cards#notification_request", :as => "notification_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  put ":code/edit" => "cards#update", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/edit" => "cards#edit", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }

  root :to => "home#home"
end
