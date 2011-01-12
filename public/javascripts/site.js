function setup_cards() {
  $('#top-card').click(function() {
    $('#middle-card').animate({top: '+=320', left:'-=5'}, 'fast', function() {
      $('#middle-card').css('z-index', top_card_z_index++);
      $('#middle-card').animate({top: '-=320', left:'+=6'}, 'fast');
    });
  });
  $('#middle-card').click(function() {
    $('#bottom-card').animate({top: '+=320', left:'+=12'}, 'fast', function() {
      $('#bottom-card').css('z-index', top_card_z_index++);
      $('#bottom-card').animate({top: '-=320', left:'-=11'}, 'fast');
    });
  });
  $('#bottom-card').click(function() {
    $('#top-card').animate({top: '+=320', left:'+=1'}, 'fast', function() {
      $('#top-card').css('z-index', top_card_z_index++);
      $('#top-card').animate({top: '-=320'}, 'fast');
    });
  });
}

function setup_login() {
  $('#login-tab').click(function() {
    var loginform = $('#site-login');
    loginform.toggleClass('display');
    // $('#login-username').focus();
    return false;
  });
}

top_card_z_index = 3;

$(document).ready(function() {
  setup_cards();
  setup_login();
});

