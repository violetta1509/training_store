$(document).on('turbolinks:load', function () {
  $("#use_billing").click(function () {
    if (this.checked) {
      $("#shipping_form").addClass("hidden")
      $("#order_use_billing").val(true)
    }
    else {
      $("#shipping_form").removeClass("hidden");
      $("#order_use_billing").val(null)
    }
  });
});
