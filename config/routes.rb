Archimede::Application.routes.draw do
    
    root :to => 'welcome#index'
    
    get "lookup" => "welcome#lookup"
    
    #admin's routes
    get "admins/show" => "admins#show"
    get "admins/destroy_notification" => "admins#destroy_notification"
    get "admins/teachers_index" => "admins#teachers_index"
    get "admins/students_index" => "admins#students_index"
    get "admins/activate" => "admins#activate"
    get "admins/new_company" => "admins#new_company"
    post "admins/create_company" => "admins#create_company"
    get "admins/destroy_company" => "admins#destroy_company"
    get "admins/companies_index" => "admins#companies_index"
    
    #teachers' routes
    get "signup" => "teachers#signup"
    get "complete_signup" => "teachers#complete_signup"
    post "create" => "teachers#create"
    post "complete" => "teachers#complete"
    get "teachers/payment" => "teachers#payment"
    get "teachers/destroy" => "teachers#destroy"
    get "teachers/show" => "teachers#show"
    post "teachers/update_data" => "teachers#update_data"
    post "teachers/update_info" => "teachers#update_info"
    post "teachers/update_bill" => "teachers#update_bill"
    post "teachers/update_subjects" => "teachers#update_subjects"
    get "payment" => "teachers#payment"
    post "teachers/change_password" => "teachers#change_password"
    
    get "teachers/generate_pdf" => "teachers#generate_pdf"
    
    #students' routes
    post "students/create" => "students#create"
    get "students/destroy" => "students#destroy"
    get "students/show" => "students#show"
    post "students/search_teacher" => "students#search_teacher"
    post "students/update" => "students#update"
    get "teachers/visit" => "teachers#visit"
    post "students/change_password" => "students#change_password"
    post "students/rate_teacher" => "students#rate_teacher"
    
    #sessions' routes
    get "login" => "sessions#login"
    post "sessions/create" => "sessions#create"
    get "logout" => "sessions#destroy"
    post "restore_password" => "sessions#restore_password"
    
    #static_pages
    get "static_pages/privacy"
    get "static_pages/terms"
    get "static_pages/faq"
end
