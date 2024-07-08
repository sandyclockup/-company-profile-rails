Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/auth/login', to: 'auth#login'
  post '/auth/register', to: 'auth#register'
  get '/auth/confirm/:token', to: 'auth#confirm'
  post '/auth/email/forgot', to: 'auth#forgot_password'
  post '/auth/email/reset/:token', to: 'auth#reset_password'

  get '/account/profile', to: 'account#profile_detail'
  post '/account/profile', to: 'account#profile_update'
  post '/account/upload', to: 'account#profile_upload'
  post '/account/password', to: 'account#password_update'

  get '/uploads/:uuid', to: 'page#getfile'
  get '/page/ping', to: 'page#ping'
  get '/page/home', to: 'page#home'
  get '/page/about', to: 'page#about'
  get '/page/service', to: 'page#service'
  get '/page/faq', to: 'page#faq'
  get '/page/contact', to: 'page#contact'
  post '/page/message', to: 'page#message'
  post '/page/subscribe', to: 'page#subscribe'

  get '/portfolio/list', to: 'portfolio#list'
  get '/portfolio/detail/:id', to: 'portfolio#detail'

  get '/article/list', to: 'article#list'
  get '/article/detail/:slug', to: 'article#detail'
  get '/article/comments/:id', to: 'article#comment_list'
  post '/article/comment/:id', to: 'article#comment_create'

end
