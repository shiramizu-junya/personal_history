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
      description: "「つづる自分史」は人生を振り返ることができるアプリです。自分の人生を振り返ってみませんか？",
      keywords: "つづる自分史, 自分史, 自分史アプリ, 人生",
      canonical: "https://www.tsuzuru-jibunshi.com/",
      icon: [
        { href: image_url("favicon/favicon.ico") },
        { href: image_url("favicon/ogp_apple_touch_icon.png"), rel: "apple-touch-icon", sizes: "180x180", type: "image/jpg" }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        # ↓を「article」に変える。
        type: "website", # ページのタイプを記載 → トップページ：content=”website”、トップページ以外：content=”article”
        url: request.original_url,
        # ↓を変更する。（絶対パス）
        image: image_url("ogp/ogp_twitter_card.png"), # SNSでシェアされた場合に表示される画像を設定
        locale: "ja_JP",
      },
      twitter: {
        card: "summary_large_image",
        site: "@webpg_jun",
      }
    }
  end
end
