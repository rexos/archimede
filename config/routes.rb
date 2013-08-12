Archimede::Application.routes.draw do

  root :to => 'welcome#index'

  #admin's routes
  get "admins/show" => "admins#show"
  get "admins/destroy_notification" => "admins#destroy_notification"
  get "admins/teachers_index" => "admins#teachers_index"
  get "admins/students_index" => "admins#students_index"
  get "admins/activate" => "admins#activate"

  #teachers' routes
  get "signup" => "teachers#signup"
  get "complete_signup" => "teachers#complete_signup"
  post "create" => "teachers#create"
  post "complete" => "teachers#complete"
  get "payment" => "teachers#payment"
  get "teachers/destroy" => "teachers#destroy"
  get "teachers/show" => "teachers#show"
  post "teachers/update_data" => "teachers#update_data"
  post "teachers/update_info" => "teachers#update_info"
  post "teachers/update_bill" => "teachers#update_bill"
  post "teachers/update_subjects" => "teachers#update_subjects"
  get "payment" => "teachers#payment"
  post "teachers/change_password" => "teachers#change_password"


  #students' routes
  post "students/create" => "students#create"
  get "students/destroy" => "students#destroy"
  get "students/show" => "students#show"
  post "students/search_teacher" => "students#search_teacher"
  post "students/update" => "students#update"
  get "teachers/visit" => "teachers#visit"
  post "students/change_password" => "students#change_password"

  #sessions' routes
  get "login" => "sessions#login"
  post "sessions/create" => "sessions#create"
  get "logout" => "sessions#destroy"
  post "restore_password" => "sessions#restore_password"

  #static_pages
  get "static_pages/privacy"
  get "static_pages/faq"
end
