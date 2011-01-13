Connecc::Application.routes.draw do

  # note: NOTHING can be a 5 character route with this implementation, we can change that later if we need to

  get ":code" => "cards#show", :as => "card", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/contact_request" => "cards#contact_request_get", :as => "contact_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/contact_request" => "cards#contact_request_post", :as => "contact_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/notification_request" => redirect("/%{code}"), :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  post ":code/notification_request" => "cards#notification_request", :as => "notification_request", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  put ":code/edit" => "cards#update", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }
  get ":code/edit" => "cards#edit", :as => "card_edit", :constraints => { :code => /[a-zA-Z0-9]{5}/ }

  devise_for :users
  get 'profile' => 'home#edit_profile'
  put 'profile' => 'home#edit_profile'
  get 'my_cards' => 'cards#index'


  namespace "admin", :path => "administration" do
    resources :orders do
      member do
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

  get "orders" => "orders#create"
  post "orders/place" => "orders#place"
  get "orders/:activation_string" => "orders#activate", :as => :order_activate
  post "orders/:activation_string" => "orders#activate_and_create_user", :as => :order_activate

  get "tour" => "home#tour"
  get "about_us" => "home#about_us"
  get "contact_us" => "home#contact_us"
  get "faq" => "home#faq"
  get "intro_video" => "home#intro_video"

  post "google_checkout_api/callback" => "google_checkout_api#callback"

  root :to => "home#home"
end
