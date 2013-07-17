Archimede::Application.routes.draw do

  root :to => 'welcome#index'

  #teachers' routes
  get "signup" => "teachers#signup"
  post "create" => "teachers#create"

end
