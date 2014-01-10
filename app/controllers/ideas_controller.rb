class IdeasController < ApplicationController

  include IdeasHelper

  before_action :signed_in_user, only: [:new, :create]
  before_action :idea_owner,     only: [:edit, :update, :destroy]
  before_action :moderator_user, only: [:toggle_published]


  def index
    @ideas = Idea.all
    filterUnpublishedIdeas if !moderator?
    filterIdeas
  end

  def show
    @idea = Idea.find(params[:id])

    if user?
      @idea_rating = @idea.idea_ratings.find_by_user_id(current_user.id)
      @idea_rating = IdeaRating.new(idea: @idea, user: current_user) unless @idea_rating
    end

    IdeaVisit.visitIdea(@idea, request.remote_ip)
  end

  def new
    session[:idea_params] ||= {}
    resetSession if session[:idea_params]['id']

    @idea = Idea.new(session[:idea_params])
    @idea.published = true if current_user.ideas.count > 10
    @idea.current_step = session[:idea_step]
  end

  def create
    session[:idea_params].deep_merge!(idea_params) if idea_params

    @idea = Idea.new(session[:idea_params])
    @idea.user = current_user

    handleStep

    if @idea.save_step? && @idea.all_valid? && @idea.save
      resetSession
      flash[:success] = 'Idea saved!'
      redirect_to @idea
    else
      render 'new'
    end
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
    @idea.published = false

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

  def toggle_published
    idea = Idea.find(params[:id])
    if idea.update_attribute(:published, !idea.published)
      flash[:success] = idea.published ? 'Idea published' : 'Idea unpublished';
    elsif
      flash[:danger] = 'Idea not changed'
    end
    redirect_to action: :index
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
                                   :duration_end,
                                   :group_size_min,
                                   :group_size_max,
                                   :age_min,
                                   :age_max,
                                   :boys,
                                   :girls,
                                   :preparation,
                                   method_category_ids: [],
                                   activity_category_ids: [],
                                   season_category_ids: [],
                                   location_category_ids: [])
    end


    def idea_owner
      unless idea_owner? (params[:id])
        flash[:warning] = 'Not your Idea'
        redirect_to(ideas_path)
      end
    end
end
