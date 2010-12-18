Connecc::Application.routes.draw do
  match "/tour" => "home#tour"
  match "/d28cx" => "home#joe"
  root :to => "home#index"
end
