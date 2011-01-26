Connecc::Application.routes.draw do

  devise_for :users

  resource :trial_order
  resources :google_orders do
    collection do
      post 'callback'
    end
  end
  resources :orders do
    collection do
      get 'preview'
    end
  end

  namespace "admin" do
    resources :orders do
      member do
        match 'cancel'
        post 'ship'
        get 'cards', :defaults => { :format => :pdf }
        get 'envelope', :defaults => { :format => :pdf }
      end
    end
    resources :users
    resources :delayed_jobs
    get "cutting_sheet" => "admin#cutting_sheet", :defaults => { :format => :pdf }
    get "/" => "admin#dashboard"
  end

  get "tour" => "home#tour"
  get "about_us" => "home#about_us"
  get "contact_us" => "home#contact_us"
  get "faq" => "home#faq"
  get "terms" => "home#terms"
  get "my_cards" => "home#my_cards"
  get "free_trial" => "home#free_trial"

  post "twilio/call" => 'twilio#call'
  post "twilio/sms" => 'twilio#sms'
  get "twilio/handle_digits" => 'twilio#handle_digits'

  scope ':code', :code => /\w{5}/, :module => 'cards' do
    resource :card, :path => '/' do
      resource :contact_request
      resource :notification_request
    end
  end

  root :to => "home#home"
end
