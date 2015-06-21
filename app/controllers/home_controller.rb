class HomeController < ApplicationController
  attr_reader

  def index
    @entities = ['anything', 'Person', 'City', 'Company', 'Organization']
    @stories = Story.where(current_user: current_user)
  end

  def new
  end

  def create
    Story.where(current_user: current_user).destroy_all
    Entity.where(current_user: current_user).destroy_all

    query = params[:query][:query].gsub(" ", "%20")
    entity = params[:query][:entity].downcase
    query_results = ApiService.call_api(query, entity)

    if query_results["result"]["docs"]
      query_results["result"]["docs"].slice(0..14).map do |story|
        check_presence_of_keywords_and_taxonomy(story)

        s = Story.create(
          title: story["source"]["enriched"]["url"]["title"],
          url: story["source"]["enriched"]["url"]["url"],
          excerpt: story["source"]["enriched"]["url"]["text"],
          keywords: clean_up_string(@keywords),
          sentiment: story["source"]["enriched"]["url"]["enrichedTitle"]["docSentiment"]["type"].capitalize,
          taxonomy: clean_up_string(@taxonomy),
          current_user: current_user
        )

        story["source"]["enriched"]["url"]["enrichedTitle"]["entities"].each do |ent|
          Entity.create(
              title: ent["text"],
              entity_type: ent["type"],
              sentiment: ent["sentiment"]["type"],
              story_id: s.id,
              current_user: current_user
            )
        end
      end
    else
      flash[:error] = "No stories were found."
    end
    redirect_to :back
  end

  private

  def clean_up_string(taxonomies)
    if taxonomies.nil? || taxonomies.empty?
      "This field was not found."
    else
      taxonomies.gsub(/^[\/]/, "").gsub("/", ", ").split.map(&:capitalize).join(' ')
    end
  end

  def check_for_taxonomy(story)
    if !story["source"]["enriched"]["url"]["enrichedTitle"]["taxonomy"].empty?
     @taxonomy = story["source"]["enriched"]["url"]["enrichedTitle"]["taxonomy"][1]["label"]
    end
  end

  def check_for_keywords(story)
    if !story["source"]["enriched"]["url"]["enrichedTitle"]["keywords"].empty?
     @keywords = story["source"]["enriched"]["url"]["enrichedTitle"]["keywords"].first["knowledgeGraph"]["typeHierarchy"]
    end
  end

  def check_presence_of_keywords_and_taxonomy(story)
    check_for_taxonomy(story)
    check_for_keywords(story)
  end
end
