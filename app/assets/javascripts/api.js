$(document).ready(function(){
  $('.entity').on('click', function(){
    var entity = $(this).find("#entity-title").text()
    $('#home_news_query').val(entity);
    $('html, body').animate({ scrollTop: 0 }, 'fast');
  })
});
