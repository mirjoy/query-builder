class HomeController < ApplicationController
  attr_reader

  def index
    @entities = ['anything', 'Person', 'City', 'Company', 'Organization']
    @stories = Story.all
  end

  def new
  end

  def create
    Story.destroy_all, Entity.destroy_all
    query = params[:home][:news_query].gsub(" ", "%20")
    entity = params[:home][:entity].downcase
    query_results = OpenStruct.new(ApiService.call_api(query, entity))

    if !query_results.result["docs"]
      @news_stories = "No stories were found."
    else
      @news_stories = query_results.result["docs"].slice(0..14).map do |story|
        s = Story.create(
          title: story["source"]["enriched"]["url"]["title"],
          url: story["source"]["enriched"]["url"]["url"],
          excerpt: "",
          keywords: "",
          sentiment: story["source"]["enriched"]["url"]["enrichedTitle"]["docSentiment"]["type"].capitalize,
          taxonomy: clean_up_taxonomy(story["source"]["enriched"]["url"]["enrichedTitle"]["taxonomy"][1]["label"])
        )
        binding.pry
        story["source"]["enriched"]["url"]["enrichedTitle"]["entities"].each do |ent|
          Entity.create(
              title: ent["text"],
              entity_type: ent["type"],
              sentiment: ent["sentiment"]["type"],
              story_id: s.id
            )
          end
      end
    end
    redirect_to :back,  flash: { :news_stories => @news_stories }
  end

  private

  def clean_up_taxonomy(taxonomies)
    taxonomies.gsub(/^[\/]/, "").gsub("/", ", ").split.map(&:capitalize).join(' ')
  end
end
