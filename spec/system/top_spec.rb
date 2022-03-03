require "rails_helper"

RSpec.describe "Top", type: :system do
  describe "Topページ" do
    context "正常系" do
      it "Topページへのリンクをクリックした場合、ページが表示されること" do
        visit(my_histories_path)
        click_link("つづる自分史")
        expect(current_path).to eq root_path
      end

      it "利用規約ページへのリンクをクリックした場合、ページが表示されること" do
        visit(root_path)
        click_link("利用規約")
        expect(current_path).to eq terms_path
      end

      it "プライバシーポリシーページへのリンクをクリックした場合、ページが表示されること" do
        visit(root_path)
        click_link("プライバシーポリシー")
        expect(current_path).to eq privacy_path
      end
    end
  end

end
