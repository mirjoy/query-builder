class HomeController < ApplicationController
  def index
    @entities = Entity.pluck(:title)
  end

  def new

  end

  def create

  end
end
