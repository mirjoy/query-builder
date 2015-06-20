$(document).ready(function(){
  $('.entity').on('click', function(){
    var entity = $(this).find("#entity-title").text()
    $('#home_news_query').val(entity);
    $('html, body').animate({ scrollTop: 0 }, 'fast');
  })

  $('.dropdown-menu li').on('click', function(){
    var selection = $(this).text();
    $('#dropdownMenu1').text(selection);
    return selection;
  });

  function sendEntityToController(query, entity){
    $.ajax ({
        method: "POST",
        url: "/home",
        data: { query: { query: query, entity: entity } },
        success: function(){
          location.reload();
        }
      });
  }

  $('#submit').on('click', function(){
    var entity = $('#dropdownMenu1').text();
    var query = $('#news-query').val();
    sendEntityToController(query, entity);
  });

});
