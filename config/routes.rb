Rails.application.routes.draw do
  root to: "memos#index"
  resources :memos, only: %i[ index show edit create update destory]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
