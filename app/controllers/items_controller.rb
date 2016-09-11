class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index
    @items = Item.all
  end

  def set_item
    @item = Item.find { params[:id]}
  end
end