$(function () {
  // 画像ライブプレビュー
  let $fileInput = $(".js-file-input");
  $fileInput.on("change", function () {
    let file = this.files[0], // 画像データを取得
      $img = $(".js-preview-image"),
      fileReader = new FileReader(); // ファイルを読み込むFileReaderオブジェクト
    // 読み込みが完了したら、imgタグにデータをセット
    fileReader.onload = function (event) {
      $img.attr("src", event.target.result);
    };
    // 画像読み込み
    fileReader.readAsDataURL(file);
  });
});
