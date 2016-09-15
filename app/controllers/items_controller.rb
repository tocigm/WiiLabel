class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index

    @items = get_items_by_parameters(params)

    if !params[:page].blank?
      @items = @items.page(params[:page])
    else
      @items = @items.page(1)
    end

    # render @items
  end

  def get_items_by_parameters(params)

    if !params[:category].blank?
      @items = Item.where(category: params[:category])
    else
      @items = Item.all
    end

    if !params[:status].blank?
      @items = @items.where(status: params[:status])
    end

    @items.order_by(_id: 'asc')
  end

  def next_item
    @items = get_items_by_parameters(params)
    @item = @items.where('_id':{'$gt': params[:id]}).order_by(_id: 'asc').limit(1).first
    # respond_to do |format|
    #   format.html {render :edit}
    # end
    if !@item.blank?
      render :edit
    else
      redirect_back fallback_location: :index
    end

  end

  def prev_item
    @items = get_items_by_parameters(params)
    @item = @items.where('_id':{'$lt': params[:id]}).order_by(_id: 'desc').limit(1).first
    if !@item.blank?
      render :edit
    else
      redirect_back fallback_location: :index
    end
  end

  def show

  end

  def update
    # logger.info params
    binding.pry
    # puts params
    respond_to do |format|
      # binding.pry
      if @item.update(status: "checked")
        params[:item][:images_attributes].each_pair{|k, v| @item.images.find(k).update(status: v['status'])}
        format.html{ redirect_to action: 'next_item'}
      end
    end
  end

  def edit
    @item.save
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:status, images_attributes: [:status])
  end

  # def render_status
  #   if @item.status == 'unchecked'
  #     render :partial => '-'
  #   else
  #     render :partial => @item.status
  #   end
  # end
end