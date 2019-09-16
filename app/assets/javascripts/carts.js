$(document).on('turbolinks:load', function() {

  $('.plus').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    input.val(quantity + 1);
  })

  $('.minus').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    if (quantity > 1) {
      input.val(quantity - 1);
    }
  })
})
