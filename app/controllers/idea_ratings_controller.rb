class IdeaRatingsController < ApplicationController

  before_action :allowed, only: [:create, :update]

  def create
    # workaround for multiple votes, if first vote
    rating = IdeaRating.find_by_idea_id_and_user_id(params[:idea_rating][:idea_id], current_user.id)
    rating = IdeaRating.new(idea_id: params[:idea_rating][:idea_id], user: current_user) unless rating

    rating.rating = params[:idea_rating][:rating]
    if rating.save
      respond_to do |format|
        format.json {
          render status: '200', json:  {
              avg: rating.idea.idea_ratings.average(:rating)
          }
        }
      end
    end
  end


  def update

    rating = IdeaRating.find(params[:id])

    rating.rating = params[:idea_rating][:rating]
    if rating.save
      respond_to do |format|
        format.json {
          render status: '200', json:  {
              avg: rating.idea.idea_ratings.average(:rating)
          }
        }
      end
    end
  end

  private
    def allowed
      unless not_idea_owner? (params[:idea_rating][:idea_id])
        flash[:warning] = 'You can not rate your own Idea'
        redirect_to(ideas_path)
      end
    end
end
