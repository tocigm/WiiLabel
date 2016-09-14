class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index

    @items = Item.all

    @items = get_items_by_parameters(params) || @items


    if !params[:page].blank?
      @items = @items.page(params[:page])
    else
      @items = @items.page(1)
    end
  end

  def get_items_by_parameters(params)
    if !params[:category].blank?
      @items = @items.where(category: params[:category])
    end

    if !params[:status].blank?
      @items = @items.where(status: params[:status])
    end
  end

  def next_item
    @items = get_items_by_parameters(params) || Item.all
    @item = @items.where('_id':{'$gt': params[:id]}).order_by(_id: 'asc').limit(1).to_a
    redirect_to @item
  end

  def prev_item
    @items = get_items_by_parameters(params) || Item.all
    @item = @items.where('_id':{'$lt': params[:id]}).order_by(_id: 'desc').limit(1).to_a
  end

  def show

  end

  def update
    # logger.info params
    # binding.pry
    # puts params
    respond_to do |format|

      if @item.update(status: "checked")
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