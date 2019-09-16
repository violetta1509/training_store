$(document).on('turbolinks:load', function() {
  $('.minimize').click(function(event) {
    var i_path = $(this).attr('src');
    $('body').append('<div id="overlay"></div><div id="magnify"><img src="'+i_path+'"><div id="close-popup"><i></i></div></div>');
    $('#magnify').css({
	    left: ($(document).width() - $('#magnify').outerWidth())/2,
            top: ($(window).height() - $('#magnify').outerHeight())/2
	  });
    $('#overlay, #magnify').fadeIn('fast');
  });

  $('body').on('click', '#close-popup, #overlay', function(event) {
    event.preventDefault();

    $('#overlay, #magnify').fadeOut('fast', function() {
      $('#close-popup, #magnify, #overlay').remove();
    });
  });

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
