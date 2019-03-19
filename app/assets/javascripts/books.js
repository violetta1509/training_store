$(document).on('turbolinks:load', function() {
  $('#plus').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    input.val(quantity + 1);
  })

  $('#minus').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    if (quantity > 1) {
      input.val(quantity - 1);
    }
  })

  $('#read-more').click(function() {
    console.log();
    let short_desc = $('#short-desc');
    let btn_link = $('#read-more');
    let full_desc = $('#full-desc');
    if (full_desc.css('display') == 'none') {
      short_desc.hide()
      btn_link.text('Close');
      full_desc.show();
    } else {
      short_desc.show();
      btn_link.text('Read more');
      full_desc.hide();
    }
  })
})
