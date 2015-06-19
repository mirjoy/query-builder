class HomeController < ApplicationController
  def index
    @entities = Entity.pluck(:title)
  end

  def new
  end

  def create
    query = params[:home][:news_query].gsub(" ", "%20")
    entity = params[:home][:entity].downcase
    query_results = OpenStruct.new(ApiService.call_api(query, entity))
binding.pry

    if query_results.result["status"] == "OK"
      @news_stories = "No stories were found."
    else
      @news_stories = query_results.result["docs"]
    end
    redirect_to :back
  end
end
