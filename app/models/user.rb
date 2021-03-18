class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :card, dependent: :destroy
                # ↑親モデルが削除された時、それに紐付ている子モデルも一緒に削除されるというオプション
  
end
