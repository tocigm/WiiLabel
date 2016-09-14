module ItemsHelper
  def render_status item
    if item.status == 'unchecked'
      return "-"
    else
      return item.status
    end
  end
end
