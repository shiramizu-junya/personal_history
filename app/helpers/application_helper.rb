module ApplicationHelper
  include Pagy::Frontend

  def page_title(page_title = "")
    base_title = "つづる自分史"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  # formエラー時のクラスのつけ外し
  def error_if(object, attribute)
    object.errors.include?(attribute) ? "error" : ""
  end
end
