Rails.application.routes.draw do

  resource :funding
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'page#index'
  get 'templates/index' => 'templates#index'
  get 'templates/register' => 'templates#register'
  get 'templates/login' => 'templates#login'
  get 'templates/funding/index' => 'templates#funding_index'
  get 'templates/kelompok_tani/index' => 'templates#kelompok_tani_index'
  get 'api/provinces' => 'application#get_provinces_data'
  get 'api/regencies/:id' => 'application#get_regencies_data'
  get 'api/districts/:id' => 'application#get_districts_data'
  get 'api/villages/:id' => 'application#get_villages_data'
  post 'api/auth/kelompok_tani/register' => 'kelompok_tani#register'
  post 'api/auth/donatur/register' => 'donatur#register'
  post 'api/auth/kelompok_tani/login' => 'kelompok_tani#post_login'
  post 'api/auth/donatur/login' => 'donatur#post_login'
  

end
