$(function () {
  // コメント編集・削除メニューの表示、非表示
  $(document).on("click", "#js-comment-edit-icon", function () {
    $(this).parent().next(".js-comment-edit-menu").toggle(150);
  });
  // 編集ボタンがclickされた時の処理
  $(document).on("click", ".js-edit-comment-button", function (e) {
    e.preventDefault();
    const commentId = $(this).data("comment-id");
    switchToEdit(commentId);
  });
  // キャンセルボタンをclickした時のイベント
  $(document).on("click", ".js-button-edit-comment-cancel", function () {
    const commentId = $(this).data("comment-id");
    clearErrorMessages(commentId);
    switchToLabel(commentId);
  });
  /*
    更新ボタンをクリックしたときのイベント。
    １、Ajax関数にデータを渡す。
    ２、成功した場合は、DOMを書き換える。
    ３、失敗した場合は、エラーメッセージを表示する。
  */
  $(document).on("click", ".js-button-comment-update", function () {
    const commentId = $(this).data("comment-id");
    clearErrorMessages(commentId);
    submitComment($("#js-textarea-comment-" + commentId).val(), commentId)
      .then((result) => {
        $("#js-comment-" + result.comment.id).find(".js-comment-content").html(
          result.comment.body.replace(/\r?\n/g, "<br>")
        );
        $(`#js-comment-twitter-${result.comment.id}`).attr(
          "href",
          "https://twitter.com/intent/tweet?text=「" +
            result.name +
            "」さんの自分史にコメントしました。%0a" +
            result.comment.body.replace(/\r?\n/g, "%0a") +
            "%0a%0a%23自分史%20%23つづる自分史%0a&url=https://www.tsuzuru-jibunshi.com/my_histories/" +
            result.uuid
        );
        switchToLabel(result.comment.id);
      })
      .catch((result) => {
        const commentId = result.responseJSON.comment.id;
        const messages = result.responseJSON.errors.messages;
        showErrorMessages(commentId, messages);
      });
  });
  /*
    コメント編集フォームを非表示にする。
    コメント内容とメニューボタンを表示する。
  */
  function switchToLabel(commentId) {
    $("#js-textarea-comment-box-" + commentId).hide();
    $("#js-comment-" + commentId).show();
    $("#js-dropdown-" + commentId).show();
  }
  /*
    コメント内容
    編集・削除メニュー
    メニュー表示ボタン を非表示にする。
    コメント編集フォーム を表示する。
  */
  function switchToEdit(commentId) {
    $("#js-comment-" + commentId).hide();
    $("#js-comment-edit-menu-" + commentId).hide();
    $("#js-dropdown-" + commentId).hide();
    $("#js-textarea-comment-box-" + commentId).show();
  }
  // エラーメッセージとclassの付与
  function showErrorMessages(commentId, messages) {
    $(
      "<div id='error_message' class='has-text-danger'> <ul> <li>" +
        messages[0] +
        "</li> </ul> </div>"
    ).insertBefore($("#js-textarea-comment-" + commentId));
    $("#js-textarea-comment-" + commentId).addClass("error");
  }
  /*
    コメント編集内容をサーバーに送信する。
  */
  function submitComment(body, commentId) {
    return new Promise(function (resolve, reject) {
      $.ajax({
        type: "PATCH",
        url: "/comments/" + commentId,
        data: {
          comment: {
            body: body,
          },
        },
      })
        .done(function (result) {
          resolve(result);
        })
        .fail(function (result) {
          reject(result);
        });
    });
  }
  // エラーメッセージとclassを削除
  function clearErrorMessages(commentId) {
    $("div#error_message").remove();
    $("#js-textarea-comment-" + commentId).removeClass("error");
  }
});
