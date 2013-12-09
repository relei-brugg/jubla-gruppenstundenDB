class IdeasController < ApplicationController

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.location_category_ids = params[:idea][:location_category_ids]
    @idea.age_category_ids = params[:idea][:age_category_ids]
    @idea.activity_category_ids = params[:idea][:activity_category_ids]
    @idea.method_category_ids = params[:idea][:method_category_ids]
    @idea.season_category_ids = params[:idea][:season_category_ids]
    @idea.group_size_category_ids = params[:idea][:group_size_category_ids]
    if @idea.save
      redirect_to @idea
    else
      render 'new'
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    @idea.location_category_ids = params[:idea][:location_category_ids]
    @idea.age_category_ids = params[:idea][:age_category_ids]
    @idea.activity_category_ids = params[:idea][:activity_category_ids]
    @idea.method_category_ids = params[:idea][:method_category_ids]
    @idea.season_category_ids = params[:idea][:season_category_ids]
    @idea.group_size_category_ids = params[:idea][:group_size_category_ids]
    if @idea.update(idea_params)
      redirect_to @idea
    else
      render 'edit'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end

  private
    def idea_params
      params.require(:idea).permit(:title,
                                   :location,
                                   :duration_preparation,
                                   :duration_total,
                                   :information,
                                   :material,
                                   :security,
                                   :remarks,
                                   :start,
                                   :main_part,
                                   :end,
                                   :duration_start,
                                   :duration_main_part,
                                   :duration_end)
    end
end
