$(document).on('turbolinks:load', function () {
  $( "#delete_account").click(function () { return false; });

  $("#enable_button").click(function () {
    if (this.checked && confirm('Your profile will be permanently deleted')) {
      $("#delete_account").removeClass("disabled");
      $("#delete_account").off('click');
    } else {
      this.checked = false;
      $("#delete_account").addClass("disabled");
      $( "#delete_account").click(function () { return false; });
    }
  });
});

function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("text");
  ev.target.appendChild(document.getElementById(data));
}

if (!window.hasOwnProperty( 'avatar' )) {
  const avatar = document.getElementById('avatar');
};

var submitBtn = document.getElementById('update_avatar');

if (submitBtn) {
  submitBtn.addEventListener('click', assign_avatar_id);
}

function assign_avatar_id(e) {
  if (avatar) {
    const input = document.getElementById('user_avatar');
    input.value = avatar.children[0].children[0].getAttribute('id');
  }
}
