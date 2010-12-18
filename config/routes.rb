Connecc::Application.routes.draw do
  match "/tour" => "home#tour"
  root :to => "home#index"
end
