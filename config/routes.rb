Archimede::Application.routes.draw do

  root :to => 'welcome#index'

  #teachers' routes
  get "signup" => "teachers#signup"
  post "create" => "teachers#create"

  #static_pages
  get "static_pages/privacy"
end
