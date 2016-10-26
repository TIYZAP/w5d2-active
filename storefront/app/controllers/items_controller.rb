class ItemsController < ApplicationController

before_action :find_item, only: [:edit, :update, :show]

  def index
    @colums = Item.column_names
    @items = Item.left_joins(:orders).group(:id).order('orders.quantity DESC')
  end

  def create
    @item = Item.new
    @item.title = params[:item][:title]
    @item.description = params[:item][:description]
    @item.category = params[:item][:category]
    @item.price = params[:item][:price]

    @item.save
    redirect_to root_path
  end

  def edit
    render :new
  end

  def show
  end

  def update
    @item.title = params[:item][:title]
    @item.description = params[:item][:description]
    @item.category = params[:item][:category]
    @item.price = params[:item][:price]

    @item.save
    redirect_to root_path(id: @item.id)
  end

  def new
    @item = Item.new
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
