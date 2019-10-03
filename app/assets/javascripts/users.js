$(document).on('turbolinks:load', function () {
  $( "#delete_account").click(function () { return false; });

  $("#enable_button").click(function () {
    if (this.checked && confirm("Press a button!")) {
      $("#delete_account").removeClass("disabled");
      $("#delete_account").off('click');
    } else {
      this.checked = false;
      $("#delete_account").addClass("disabled");
      $( "#delete_account").click(function () { return false; });
    }
  });
});
