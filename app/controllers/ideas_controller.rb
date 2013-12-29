class IdeasController < ApplicationController

  include IdeasHelper

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    session[:idea_params] ||= {}
    resetSession if session[:idea_params]['id']

    @idea = Idea.new(session[:idea_params])
    @idea.current_step = session[:idea_step]
  end

  def create
    session[:idea_params].deep_merge!(idea_params) if idea_params

    @idea = Idea.new(session[:idea_params])

    handleStep

    if @idea.save_step? && @idea.all_valid? && @idea.save
      resetSession
      flash[:success] = 'Idea saved!'
      redirect_to @idea
    else
      render 'new'
    end

   # @idea.group_size_category_ids = params[:idea][:group_size_category_ids]
  end

  def edit
    @idea = Idea.find(params[:id])
    session[:idea_step] = 0
    session[:idea_params] = @idea.attributes
  end

  def update
    session[:idea_params].deep_merge!(idea_params) if idea_params

    @idea = Idea.find(session[:idea_params]['id'])
    @idea.attributes = session[:idea_params]

    handleStep

    if @idea.save_step? && @idea.all_valid? && @idea.update(idea_params)
      resetSession
      flash[:success] = 'Idea updated!'
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
