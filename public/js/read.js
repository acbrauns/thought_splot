$(document).ready(function(){

  $('.accordion').find('.accordion-toggle').click(function(){
        //Expand or collapse this panel
    $(this).next().slideToggle('fast');
        //Hide the other panels
     $(".accordion-content").not($(this).next()).slideUp('fast');
  });

  var $journals = $('.all_journals');

  for (var i = 0; i < $journals.length; i++){
    var $font = $($journals[i]).attr('id');

    var title = $font.split('+').join(' ');

    $($journals[i]).css('font-family', title);


    $('head').append($('<link>').attr('rel', 'stylesheet').attr('type', 'text/css').attr('href', 'https://fonts.googleapis.com/css?family=' + $font));
  }

});

