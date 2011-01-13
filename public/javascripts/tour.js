function frame1() {
    $('#tour').fadeIn(1000);
}

function tour() {
    $('#strip, .stripCurl, footer, #menu').slideUp(1000, function() {
      setTimeout(frame1, 1000);
    });
}

$(document).ready(function () {
    $('#tour-start').attr('href', '#');
    $('#tour-start').click(function() {
        tour();
    });
});


