class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  def index
    @items = Item.all.order('created_at DESC')
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

  def show
  end

  def edit
    redirect_to root_path if @item.purchase.present?
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduce, :price, :category_id, :status_id, :pay_for_shopping_id,
                                 :delivery_area_id, :day_to_ship_id).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def find_params
    @item = Item.find(params[:id])
  end
end
