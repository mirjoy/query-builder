$(document).ready(function(){
  $('.entity').on('click', function(){
    var entity = $(this).find("#entity-title").text()
    $('#news-query').val(entity);
    $('html, body').animate({ scrollTop: 0 }, 'fast');
  })

  $('.dropdown-menu li').on('click', function(){
    var selection = $(this).text();
    $('#dropdownMenu1').text(selection);
    return selection;
  });

  function sendMsgNoStoriesPresent(){
    if ($(document.getElementById("entity-title")).length === 0){
      $('#submit-row').append('<div class="row col-sm-12"><em><p>No stories found, try a different search.</p></em></div>');
    }
  }

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

  sendMsgNoStoriesPresent();
});
