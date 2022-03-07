module MyHistoryPreparation
  def my_history_as(title_flag, my_history_flag)
    visit(new_my_history_path)
    fill_in("birthday", with: Date.current.ago(20.years).strftime("00%Y-%m-%d"))
    select("男性", from: "gender")
    click_button("更新")

    if(title_flag)
      fill_in("title", with: "メインタイトル")
      click_button("追加")
    end

    if(my_history_flag)
      click_button("出来事追加")
      fill_in("age", with: "10")
      fill_in("happiness", with: "50")
      fill_in("title", with: "サブタイトル")
      fill_in("episode", with: "エピソード")
      click_button("追加")
    end
  end
end
