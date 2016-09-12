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
        len = @item.images.length
        i = 0
        begin
          @item.images[i].update(status: "xxx")
          i +=1
        end until i >= len
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