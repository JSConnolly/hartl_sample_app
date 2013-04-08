
$(document).ready(function($){
  $('body').chardinJs();
  $('.chardin').on('click', function(){
    $('body').chardinJs('toggle');
  });

  $('body').on('chardinJs:start', function(){
    $('span.chardin-show').toggleClass('chardinjs-show-element chardinjs-relative-position');
  });

})(jQuery);