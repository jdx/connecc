var Connecc = {

    setupCards:function() {
      $('#top-card')
          .click(function() {
              $('#middle-card')
                  .animate(
                      { top:'+=320', left:'-=5' }, 
                      'fast', 
                      function() {
                          $('#middle-card')
                              .css('z-index', Connecc.topCardZIndex++);
                          $('#middle-card')
                              .animate(
                                  { top:'-=320', left:'+=6' }, 
                                  'fast'
                              );
                      }
                  );
          });
      
      $('#middle-card')
          .click(function() {
              $('#bottom-card')
                  .animate(
                      { top:'+=320', left:'+=12' }, 
                      'fast', 
                      function() {
                          $('#bottom-card')
                              .css('z-index', Connecc.topCardZIndex++);
                          $('#bottom-card')
                              .animate(
                                  { top:'-=320', left:'-=11' }, 
                                  'fast'
                              );
                      }
                  );
          });
          
      $('#bottom-card')
          .click(function() {
              $('#top-card')
                  .animate(
                      { top:'+=320', left:'+=1' }, 
                      'fast', 
                      function() {
                          $('#top-card')
                              .css('z-index', Connecc.topCardZIndex++);
                          $('#top-card')
                              .animate(
                                { top:'-=320' }, 
                                'fast'
                          );
                      }
                  );
          });
    },

    setupLogin:function() {
      $('a#login')
          .click(function() {
              $('#site-login')
                  .toggleClass('display');
              
              $('#user_email').focus();
              
              return false;
          });
    },

    setupColorpicker:function() {
      $('.colorpicker').farbtastic('input.color');
    },

    topCardZIndex:3
};

$(function() {
  Connecc.setupCards();
  Connecc.setupLogin();
  Connecc.setupColorpicker();
});

