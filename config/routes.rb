Rails.application.routes.draw do
# 顧客用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root 'homes#top'
  get 'homes/about' => 'homes#about'

namespace :public do #namespace :usersをpublicに変更しました。

  resource :users, only: [:show, :update, :edit] do
      # 退会確認画面
      get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch '/users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    end

  resources :games, only: [:index, :show]

  get 'users/unsubscribe' => 'users#unsubscribe'
  patch 'users/withdraw' => 'users#withdraw'

end



# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
end

end
