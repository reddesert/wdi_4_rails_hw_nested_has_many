SharedBlog::Application.routes.draw do
  resources :users do
    resources :articles do
      resources :comments
    end
  end
  root to: 'articles#index'
end