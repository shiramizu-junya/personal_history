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

  def default_meta_tags
    {
      site: "つづる自分史 | 人生を振り返る旅に出よう",
      title: "つづる自分史 | 人生を振り返る旅に出よう",
      reverse: true,
      charset: "utf-8",
      separator: "|",
      description: "人生を振り返る旅に出よう",
      keywords: "自分史",
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url("favicon/favicon.ico") },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp/ogp.png"),
        locale: "ja_JP",
      },
      twitter: {
        card: "summary_large_image",
        site: "@webpg_jun",
        image: image_url("ogp/ogp.png")
      }
    }
  end
end
