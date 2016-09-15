class AdminsController < ApplicationController

  def index

  end

  def update_category
    # binding.pry
    Category.delete_all
    @categories = Item.only(:category).distinct(:category)

    for i in @categories
      Category.create(name: i)
    end
  end
end
