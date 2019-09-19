$(document).on('turbolinks:load', function () {
  $( "#delete_account").click(function () {return false;});

  $("#enable_button").click(function () {
    if (this.checked) {
      $("#delete_account").removeClass("disabled");
      $("#delete_account").off('click');
    } else {
      $("#delete_account").addClass("disabled");
      $( "#delete_account").click(function () {return false;});
    }
  });
});
