module ApplicationHelper
  def page_title(page_title = '')
    base_title = "人生の軌跡"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
