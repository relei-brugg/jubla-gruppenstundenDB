class IdeasController < ApplicationController

  include IdeasHelper

  before_action :signed_in_user, only: [:new, :create]
  before_action :idea_owner,     only: [:edit, :update, :destroy]
  before_action :moderator_user, only: [:toggle_published, :unpublished]

  def index
    @ideas = Idea.order(:title).page(params[:page])

    filterUnpublishedIdeas if !moderator?
    filterIdeas

    @title = 'Gruppenstunden'
    @table = 'default'
  end

  def unpublished
    @ideas = Idea.where(published: false).page(params[:page])
    filterIdeas

    @title = 'Unveröffentlichte Gruppenstunden'
    @table = 'default'
    render 'index'
  end

  def top_rated
    @ideas = Idea.all.joins(:idea_ratings).group('ideas.id').order('avg(idea_ratings.rating) desc').page(params[:page])

    filterUnpublishedIdeas if !moderator?
    filterIdeas

    @title = 'Beste Gruppenstunden'
    @table = 'default'
    render 'index'
  end

  def most_viewed
    @ideas = Idea.all.order('views desc').page(params[:page])

    filterUnpublishedIdeas if !moderator?
    filterIdeas

    @title = 'Beliebteste Gruppenstunden'
    @table = 'default'
    render 'index'
  end

  def user
    user = User.find(params[:id])
    @ideas = Idea.where(user: user).page(params[:page])

    filterUnpublishedIdeas if (user != current_user)
    filterIdeas

    @title = User.find(params[:id]).name + "'s Gruppenstunden"
    @table = (user == current_user) ? 'user_view' : 'default'
    render 'index'
  end

  def show
    @idea = Idea.find(params[:id])

    if not_idea_owner? (params[:id])
      @idea_rating = @idea.idea_ratings.find_by_user_id(current_user.id)
      @idea_rating = IdeaRating.new(idea: @idea, user: current_user) unless @idea_rating
    end

    IdeaVisit.visit(@idea, request.remote_ip)
  end

  def print
    @idea = Idea.find(params[:id])

    IdeaVisit.visit(@idea, request.remote_ip, true)
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'print', layout: false
      end
    end
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
      UserMailer.new_idea_email(@idea).deliver
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
