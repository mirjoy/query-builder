class HomeController < ApplicationController
  attr_reader

  def index
    @entities = Entity.pluck(:title)
    @stories = Story.all
    @news_stories = params[:news_stories] if params[:news_stories]
  end

  def new
  end

  def create
    Story.destroy_all
    query = params[:home][:news_query].gsub(" ", "%20")
    entity = params[:home][:entity].downcase
    query_results = OpenStruct.new(ApiService.call_api(query, entity))

    if !query_results.result["docs"]
      @news_stories = "No stories were found."
    else
      @news_stories = query_results.result["docs"].map do |story|
        Story.create(
          title: story["source"]["enriched"]["url"]["title"],
          url: story["source"]["enriched"]["url"]["url"],
          excerpt: "",
          keywords: "",
          entity: "",
          sentiment: story["source"]["enriched"]["url"]["enrichedTitle"]["docSentiment"]["type"],
          taxonomy: story["source"]["enriched"]["url"]["enrichedTitle"]["taxonomy"][1]["label"]
       )
      end
    end

    redirect_to :back,  flash: { :news_stories => @news_stories }
  end
end
