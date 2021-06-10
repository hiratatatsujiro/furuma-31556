class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduce, :price, :category_id, :status_id, :pay_for_shopping_id, :delivery_area_id, :days_to_ship_id).merge(user_id: current_user.id)
  end
end
