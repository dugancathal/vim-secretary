(function($){
  $('input.search').keyup(function() {
    var inputVal = $(this).val();
    if(inputVal.length > 2) {
      $("input.search + .result").fadeIn();
      $('input.search + .result').empty();
      $.get('/search', {fragment : inputVal}, function(data) {
        JSON.parse(data).map(function(item, i) {
          $('input.search + .result').append(
            $('<div/>').addClass('display-box').data('id', item.id).append(
              $('<a/>').attr('href', '/punches/' + item.id).html(item.description)
            )
          )
        })
      })
    }
  });

  $(".result .display-box").on("click",function(){
    console.log($clicked);
    var $clicked = $(e.target);
    window.location = + $clicked.data('id');
  });

  $('input.search').on("focus", function(){
    if(this.value.length > 2) {
      $("input.search + .result").fadeIn();
    }
  });

  $('input.search').on("blur", function(){
    $("input.search + .result").fadeOut();
  });
})(jQuery);
