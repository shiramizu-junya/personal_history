$(function () {
  $(document).on("click", "#js-comment-edit-icon", function () {
    $(this).parent().next("#js-comment-edit-menu").toggle(150);
  });
});
