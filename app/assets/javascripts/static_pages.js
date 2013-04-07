
$(document).ready(function($){
  $('body').chardinJs();
  $('.chardin').on('click', function(){
    $('body').chardinJs('toggle');
  });

  $('body').on('chardinJs:start', function(){
    $('.chardin').toggleClass('chardinjs-show-element chardinjs-relative-position');
  });

})(jQuery);