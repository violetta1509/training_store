$(document).on('turbolinks:load', function () {
  $("#enable_button").click(function () {
    if (this.checked) {
      $("#delete_account").removeClass("disabled");
    } else {
      $("#delete_account").addClass("disabled");
    }
  });
});
