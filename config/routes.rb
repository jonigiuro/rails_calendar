CalendarTest::Application.routes.draw do

  devise_for :users
  resources :comments
  resources :attends

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  root :to  => 'calendar#index'

  match '/events/:id'  => 'events#show', :via  => :get

  match '/events/:id'  => 'events#destroy'

  resources :users do
    resources :events
  end

  match "/day/:year(/:month(/:day))"  => 'events#day', :constraints  => { :year  => /\d{4}/, :month  => /\d{2}/, :day  =>  /\d{2}/ }

end
