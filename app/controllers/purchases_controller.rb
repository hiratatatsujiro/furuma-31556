class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params, only: [:index, :create]
  before_action :move_to_index, only: :index
  
  def index
    @purchase_shopping = PurchaseShopping.new
  end

  def create
    @purchase_shopping = PurchaseShopping.new(purchase_params)
    if @purchase_shopping.valid?
      pay_item
      @purchase_shopping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_shopping).permit(:postal_code, :delivery_area_id, :city, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if @item.purchase.present? || @item.user_id == current_user.id
  end

  def item_params
    @item = Item.find(params[:item_id])
  end
end
