$(document).ready(function() {
    $('#find-code-button').click(function() {
        var code = $('#find-code-input').val();
        if (!/^[a-zA-Z0-9]{5}$/.test(code)) {
            alert('Code must be 5 letters/numbers');
        }
        else {
            $.ajax({
              url: '/' + code,
              success: function(data) {
                           $.mobile.changePage("/" + code);
                       },
              error: function(data) {
                        alert('Error: No card found');
              },
            });
        }
    });
});
