Archimede::Application.routes.draw do

  root :to => 'welcome#index'

  #teachers' routes
  get "signup" => "teachers#signup"
  get "complete_signup" => "teachers#complete_signup"
  post "create" => "teachers#create"
  post "complete" => "teachers#complete"
  get "payment" => "teachers#payment"
  get "teachers/index" => "teachers#index"
  get "teachers/destroy" => "teachers#destroy"
  get "teachers/show" => "teachers#show"
  get "teachers/activate" => "teachers#activate"
  get "payment" => "teachers#payment"

  #students' routes
  post "students/create" => "students#create"
  get "students/index" => "students#index"
  get "students/destroy" => "students#destroy"
  get "students/show" => "students#show"
  post "students/search_teacher" => "students#search_teacher"
  post "students/update" => "students#update"
  get "teachers/visit" => "teachers#visit"

  #sessions' routes
  get "login" => "sessions#login"
  post "sessions/create" => "sessions#create"
  get "logout" => "sessions#destroy"

  #static_pages
  get "static_pages/privacy"
  get "static_pages/faq"
end
