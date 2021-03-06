class Game < ApplicationRecord

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	belongs_to :user
	has_many :favorites, dependent: :destroy
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
	has_many :game_comments, dependent: :destroy
	validates :title, :body, presence: true
	validates :body, length: {maximum: 200}

	attachment :image


end
