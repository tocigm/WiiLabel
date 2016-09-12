class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index
    @items = Item.all
  end

  def show

  end

  def update
    respond_to do |format|
      if @item.update(status: "yes")
        @item.images do |image|
          image.update(status: "yes")
        end
        format.html{ redirect_to action: 'show'}
      end
    end
  end

  def edit

  end

  def set_item
    @item = Item.find(params[:id])
  end
end