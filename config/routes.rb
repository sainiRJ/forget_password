Rails.application.routes.draw do

  root 'users#index'

  get '/user/register', to: 'users#create'

  post '/user/register', to: 'users#new'

  get '/user/login', to: 'users#login_form'
  
  post '/user/login', to: 'users#login'

  get '/user/get/:id', to: 'users#get_user'
 
  get '/user/list/:page', to: 'users#allUser'

  delete '/user/delete/:id', to: 'users#delete_user'

  get '/user/delete/:id', to: 'users#delete_user'


  get '/user/reset', to: 'users#resetMail_form'

  post '/user/reset', to: 'users#reset_mail'

  get '/user/forget/:token', to: 'users#forget_password',  :constraints => { :token => /[^\/]+/ }

  post '/user/forget', to: 'users#update_password',  :constraints => { :token => /[^\/]+/ }


end
