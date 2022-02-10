$(function () {
  $(document).on("click", "#js-comment-edit-icon", function () {
    $(this).parent().next(".js-comment-edit-menu").toggle(150);
  });

  $(document).on("click", ".js-edit-comment-button", function (e) {
    e.preventDefault();
    const commentId = $(this).data("comment-id");
    switchToEdit(commentId);
  });

  $(document).on("click", ".js-button-edit-comment-cancel", function () {
    const commentId = $(this).data("comment-id");
    clearErrorMessages(commentId);
    switchToLabel(commentId);
  });

  $(document).on("click", ".js-button-comment-update", function () {
    const commentId = $(this).data("comment-id");
    clearErrorMessages(commentId);
    submitComment($("#js-textarea-comment-" + commentId).val(), commentId)
      .then((result) => {
        $("#js-comment-" + result.comment.id).find(".js-comment-content").html(
          result.comment.body.replace(/\r?\n/g, "<br>")
        );
        switchToLabel(result.comment.id);
      })
      .catch((result) => {
        const commentId = result.responseJSON.comment.id;
        const messages = result.responseJSON.errors.messages;
        showErrorMessages(commentId, messages);
      });
  });

  function switchToLabel(commentId) {
    $("#js-textarea-comment-box-" + commentId).hide();
    $("#js-comment-" + commentId).show();
    $("#js-dropdown-" + commentId).show();
  }

  function switchToEdit(commentId) {
    $("#js-comment-" + commentId).hide();
    $("#js-comment-edit-menu-" + commentId).hide();
    $("#js-dropdown-" + commentId).hide();
    $("#js-textarea-comment-box-" + commentId).show();
  }

  function showErrorMessages(commentId, messages) {
    $(
      "<div id='error_message' class='has-text-danger'> <ul> <li>" +
        messages[0] +
        "</li> </ul> </div>"
    ).insertBefore($("#js-textarea-comment-" + commentId));
    $("#js-textarea-comment-" + commentId).addClass("error");
  }

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

  function clearErrorMessages(commentId) {
    $("div#error_message").remove();
    $("#js-textarea-comment-" + commentId).removeClass("error");
  }
});
