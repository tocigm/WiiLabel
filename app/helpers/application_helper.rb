module ApplicationHelper
  def menu
    @menu =  Category.all
  end
end
