function setup_cards() {
  $('#top-card').click(function() {
    $('#middle-card').animate({top: '+=170', left:'-=5'}, 'fast', function() {
      $('#middle-card').css('z-index', top_card_z_index++);
      $('#middle-card').animate({top: '-=170', left:'+=6'}, 'fast');
    });
  });
  $('#middle-card').click(function() {
    $('#bottom-card').animate({top: '+=170', left:'+=12'}, 'fast', function() {
      $('#bottom-card').css('z-index', top_card_z_index++);
      $('#bottom-card').animate({top: '-=170', left:'-=11'}, 'fast');
    });
  });
  $('#bottom-card').click(function() {
    $('#top-card').animate({top: '+=170', left:'+=1'}, 'fast', function() {
      $('#top-card').css('z-index', top_card_z_index++);
      $('#top-card').animate({top: '-=170'}, 'fast');
    });
  });
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

