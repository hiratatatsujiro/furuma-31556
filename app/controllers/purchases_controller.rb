class PurchasesController < ApplicationController
  before_action :authenticate_user!
  def index
   @item = Item.find(params[:item_id])  
   @purchase_shopping = PurchaseShopping.new
   move_to_index
  end

  def create
    @item = Item.find(params[:item_id])  
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
    params.require(:purchase_shopping).permit(:postal_code, :delivery_area_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: params[:token],   
      currency: 'jpy'                
      )
  end

  def move_to_index
    if @item.purchase.present? || @item.user_id == current_user.id
      redirect_to root_path
    end
  end
  
end
