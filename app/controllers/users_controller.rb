class UsersController < ApplicationController
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id)# ユーザーのid情報をもとにカード情報を取得

    redirect_to new_card_path and return unless card.present?
    
    customer = Payjp::Customer.retrieve(card.customer_token) # 上のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to "show"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
