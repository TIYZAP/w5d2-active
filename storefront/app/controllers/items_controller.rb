class ItemsController < ApplicationController

def index
  @colums = Item.column_names
  @items = Item.joins(:orders).group(:id).order('orders.quantity DESC')
end

def create
  # @item = Item.all
  # @item.title = params[:title]
  # @item.description = params[:item][:description]
  # @item.category = params[:item][:category]
  # @item.price = params[:item][:price]
  # @item.total = params[:item][:total]

  # @item.save
  # redirect_to root_path\
end

  def show
  end

  def new
  end




end
