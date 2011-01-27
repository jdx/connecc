var Connecc = {

    setupLogin:function() {
      $('a#login')
          .click(function() {
              $('#site-login')
                  .toggleClass('display');
              
              $('#site-login_user_email').focus();
              
              return false;
          });
    },

    setupColorpicker:function() {
        $('.colorpicker').farbtastic('input.color');
    },

    setupDefaultButtons:function() {
        // This grabs a default button and sets it's paired 'field' to it's 'value'

        $('input.default').click(function() {
            field = $($(this).data('field'));
            value = $(this).data('value');
            field.val(value);

            field.keyup(); // needed for farbtastic colorpicker
        });
    },

    setupForms:function() {
      Connecc.setupColorpicker();
      Connecc.setupDefaultButtons();
      Connecc.setupPreviewButtons();
    },

    setupPreviewButtons:function() {
        $('#preview').show();
        Connecc.loadPreview();
        $('#preview input').click(Connecc.loadPreview);
    },

    loadPreview:function() {
        src = '/orders/preview.png?';
        src += 'first_name=' + escape($('input.first_name').val());
        src += '&last_name=' + escape($('input.last_name').val());
        src += '&company_name=' + escape($('input.company_name').val());
        $('form #preview img').attr('src', src);
    },

    topCardZIndex:3
};

$(function() {
  Connecc.setupLogin();
  Connecc.setupForms();
});

