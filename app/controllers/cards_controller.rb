class CardsController < ApplicationController
  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 環境変数を読み込む
    customer = Payjp::Customer.create(
      description: 'test', # テストカードであることを説明
      card: params[:card_token] # 登録しようとしているカード情報
      )

      # トークン化されたカード情報を保存する
      card = Card.new(
        card_token: params[:card_token], # カードトークン
        customer_token: customer.id, # 顧客トークン
        user_id: current_user.id # ログインしているユーザー
      )
      if card.save
        redirect_to root_path
      else
        redirect_to "new"
      end
      # //トークン化されたカード情報を保存する
  end
end
