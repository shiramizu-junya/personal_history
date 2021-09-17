require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrajectoryLife
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # アプリケーションやアクティブレコード(created_atなど)で使用するデフォルトのタイムゾーンの設定
    config.time_zone = 'Tokyo'

    # DBを読み書きする際に、DBに記録されている時間をどのタイムゾーンで解釈するかの設定
    config.active_record.default_timezone = :local

    # I18nライブラリに訳文の探索場所を指示する設定
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # アプリケーションが対応している言語のホワイトリスト(ja = 日本語, en = 英語)
    config.i18n.available_locales = %i[ja]

    # デフォルトのlocaleを日本語(:ja)に設定
    config.i18n.default_locale = :ja

    # Don't generate system test files.
    config.generators.system_tests = nil

    # ジェネレータの設定
    config.generators do |g|
      g.assets false          # CSS, JavaScriptファイル生成しない
      g.skip_routes true     # trueならroutes.rb変更せず、falseなら通常通り変更
      g.helper false          # helperファイル生成しない
      g.test_framework :rspec,    # RSpecを使用
        controller_specs: false,  # controller specは作らない
        view_specs: false,        # view specは作らない
        helper_specs: false,      # helper specは作らない
        routing_specs: false      # routing specは作らない
    end

    # formのエラー時はdivタグを作らない
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      %Q(#{html_tag}).html_safe
    }
  end
end
