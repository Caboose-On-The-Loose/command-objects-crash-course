Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts, only: [:index, :new, :create, :show] do
    scope module: :posts do
      resources :replies, only: [:new, :create]
    end
  end

  scope module: :pages do
    get 'help/rate-limited' => 'help#rate_limited'
    get 'help/spam' => 'help#spam'
  end
end
