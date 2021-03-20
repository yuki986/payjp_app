class ItemsController < ApplicationController
  before_action :find_item, only: :order
  def index
    @items = Item.all
  end

  def order
    # card情報とユーザー情報が一致しないならcardの登録ページに戻る
    redirect_to new_card_path and return unless current_user.card.present?

    # Payjpに商品の金額情報を保存できるよう記述する
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
      )
      # //Payjpに商品の金額情報を保存できるよう記述する

    ItemOrder.create(item_id: params[:id]) # 商品のid情報を「item_id」として保存する
    redirect_to root_path
  end

  private
  def find_item
    @item = Item.find(params[:id])
  end
end
