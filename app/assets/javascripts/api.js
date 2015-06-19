$(document).ready(function(){


  function callApi(query, entity){
    $.ajax({
      url: "https://access.alchemyapi.com/calls/data/GetNews?apikey=" + key + "&return=enriched.url.title&start=now-10d&end=now&count=15&outputMode=json&q.enriched.url.enrichedTitle.entities.entity=|text=" + query + ",type=" + entity + "|",
      context: document.body
    }).done(function(result) {
      console.log("worked");
      console.log(result);
      return result
    });
  }
  $('#submit-btn').on('click', function(){
    var query = $('#home_news_query').val();
    var entity = $('#home_entity').val();
    callApi(query, entity);
  });


});
