class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index
    @items = Item.all

    if !params[:category].blank?
      @items = @items.where(category: params[:category])
    end

    if !params[:status].blank?
      @items = @items.where(status: params[:status])
    end
  end

  def show

  end

  def update
    # logger.info params
    # binding.pry
    # puts params
    respond_to do |format|

      if @item.update(status: "edited")
        params[:item][:images_attributes].each_pair{|k, v| @item.images.find(k).update(status: v['status'])}
        format.html{ redirect_to action: 'show'}
      end
    end
  end

  def edit

  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:status, images_attributes: [:status])
  end
end