class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
   if item = find_item
    render json: item
   else
    render_not_found_response
   end
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end





  private
  def item_params
    params.permit(:name, :description, :price)
  end

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end
end
