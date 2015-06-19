class HomeController < ApplicationController
  def index
    @entities = Entity.pluck(:title)
  end

  def new
  end

  def create
    query = params[:home][:news_query].gsub(" ", "%20")
    entity = params[:home][:entity].downcase
    @query_results = ApiService.call_api(query, entity)

    redirect_to :back
  end
end
