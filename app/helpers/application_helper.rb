module ApplicationHelper
  def page_title(page_title = "")
    base_title = "人生の軌跡"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  # formエラー時のクラスのつけ外し
  def error_if(object, attribute)
    object.errors.include?(attribute) ? "error" : ""
  end
end
