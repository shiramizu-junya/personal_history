# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.tsuzuru-jibunshi.com/"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = "tmp/"
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{Rails.application.credentials.aws[:s3_bucket]}/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
                                          fog_provider: "AWS",
                                          aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
                                          aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
                                          fog_directory: Rails.application.credentials.aws[:s3_bucket],
                                          fog_region: "ap-northeast-1")

SitemapGenerator::Sitemap.create do
  # トップページ
  add root_path, priority: 1, changefreq: "daily"
  # 自分史一覧
  add my_histories_path, priority: 0.7, changefreq: "daily"
end
