module ApplicationHelper
  def menu
    @menu =  Item.only(:category).distinct(:category)
  end
end
