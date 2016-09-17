class ItemsController < ApplicationController
  before_action :set_item, except: [:index]
  def index

    @items = get_items_by_parameters(params)

    if !params[:page].blank?
      @items = @items.page(params[:page])
    else
      @items = @items.page(1)
    end

    if !params[:category].blank?
      @category = Category.find(params[:category])[:name]
    else
      @category = 'All Categories'
    end


    # render @items
  end

  def get_items_by_parameters(params)
    # binding.pry
    if !params[:category].blank?
      @category = Category.find(params[:category])
      if !@category.nil?
        @items = Item.where(category: @category[:name])
      end

    else
      @items = Item.all
    end

    if !params[:status].blank?
      if params[:status] == 'checked'
        @items = @items.where(status: 'checked')
      else
        @items = @items.where(:status.nin => ['checked', 'deleted'])
      end


    end

    @items.order_by(_id: 'asc')
  end

  def next_item
    # binding.pry
    @items = get_items_by_parameters(params: {category: params[:category]})
    @item = @items.where('_id':{'$gt': params[:id]}).order_by(_id: 'asc').limit(1).first
    # respond_to do |format|
    #   format.html {render :edit}
    # end
    if !@item.blank?
      redirect_to proc { edit_item_path(@item, params: {category: params[:category]})} #, status: params[:status]
    else
      redirect_back fallback_location: :index
    end

  end

  def prev_item
    @items = get_items_by_parameters(params: {category: params[:category]})
    @item = @items.where('_id':{'$lt': params[:id]}).order_by(_id: 'desc').limit(1).first
    if !@item.blank?
      redirect_to proc { edit_item_path(@item, params: {category: params[:category]})} #, status: params[:status]
    else
      redirect_back fallback_location: :index
    end
  end

  def show

  end

  def update
    # logger.info params
    # binding.pry
    # puts params
    respond_to do |format|
      # binding.pry
      if !@item.images.blank?
        params[:item][:images_attributes].each_pair{|k, v| @item.images.find(k).update(status: v['status'])}
      end
      @category = Category.find_by(name: params[:item][:category].to_s.remove(/[\[\]\"\"]/))
      if @item.update(status: "checked")
        @items = get_items_by_parameters(params: {category: @category.id})  #status: params[:item][:status]
        @next_item = @items.where('_id':{'$gt': @item.id}).order_by(_id: 'asc').limit(1).first
        format.html{ redirect_to proc { edit_item_path(@next_item, params: {category: @category.id})}} #, status: params[:item][:status]
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item.update(status: "deleted")
        format.html{ redirect_to proc { edit_item_path(@item, params: {category: params[:category], status: params[:status]})}}
      end
    end
  end

  def edit
    # binding.pry
    @item.save

    if !@item.images.blank?
      i = 0
      len = @item.images.count
      until i < len
        @item.images[i].save
        puts item.images[i].id
        i+=1
      end
    end

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