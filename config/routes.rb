Archimede::Application.routes.draw do

  root :to => 'welcome#index'

  #teachers' routes
  get "signup" => "teachers#signup"
  post "create" => "teachers#create"
  get "teachers/index" => "teachers#index"
  get "teachers/destroy" => "teachers#destroy"
  get "teachers/activate" => "teachers#activate"

  #students' routes
  post "students/create" => "students#create"
  get "students/index" => "students#index"
  get "students/destroy" => "students#destroy"

  #static_pages
  get "static_pages/privacy"
end
