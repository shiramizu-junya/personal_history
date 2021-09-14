module ActionView
  module Helpers
    module ActiveModelInstanceTag
      # ラジオボタンに「field_with_errors」クラスがつかないよう設定
      def tag_generate_errors?(options)
        (options["type"] != "hidden" && options["type"] != "radio")
      end
    end
  end
end
