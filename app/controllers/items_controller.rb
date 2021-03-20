class ItemsController < ApplicationController
  before_action :find_item, only: :order
  def index
    @items = Item.all
  end

  def order
    # card情報とユーザー情報が一致しないならcardの登録ページに戻る
    redirect_to new_card_path and return unless current_user.card.present?

    ItemOrder.create(item_id: params[:id]) # 商品のid情報を「item_id」として保存する
    redirect_to root_path
  end

  private
  def find_item
    @item = Item.find(params[:id])
  end
end
