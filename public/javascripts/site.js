function setup_cards() {
}

function setup_login() {
  $('#login-tab').click(function() {
    var loginform = $('#login-form');
    if (loginform.css('top') == '-1px') {
      loginform.css('top', '');
    }
    else {
      loginform.css('top', '-1px');
      $('#login-username').focus();
    }
  });
}

top_card_z_index = 3;

$(document).ready(function() {
  setup_cards();
  setup_login();
});

