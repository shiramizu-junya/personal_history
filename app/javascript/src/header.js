$(function () {
  // ヘッダーの高さ分だけコンテンツを下げる（ヘッダーのposition: fixed; 対策）
  let height = $(".js-get-height").innerHeight();
  $(".wrap").css("padding-top", height);

  // ハンバーガーメニューのアニメーション
  $(".js-toggle-is-active").on("click", function () {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").slideToggle(300);
  });

  // フラッシュメッセージ表示
  let $jsShowMsg = $("#js-show-msg");
  let msg = $jsShowMsg.text();
  $jsShowMsg.height(height);
  $jsShowMsg.css("line-height", `${height}px`);
  // replaceメソッドで空白を削除
  if (msg.replace(/^[\s　]+|[\s　]+$/g, "").length) {
    $jsShowMsg.slideToggle("slow");
    setTimeout(function () {
      $jsShowMsg.slideToggle("slow");
    }, 5000);
  }
});
