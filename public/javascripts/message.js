$(document).ready(function() {
    $('.no-ie #message .open-form').click(function() {
        $(this).addClass('no-transitions');
        $(this).fadeOut(500, function() {
          $('.hidden-form').slideDown();
        });
        return false;
    });
});
