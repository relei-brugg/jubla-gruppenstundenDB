module IdeasHelper
  def handleStep
    @idea.current_step = session[:idea_step]

    if params[:back_button]
      @idea.previous_step
    else
      @idea.next_step if @idea.valid?
    end

    session[:idea_step] = @idea.current_step
  end

  def resetSession
    session[:idea_step] = 0
    session[:idea_params] = {}
  end


  def filterIdeas
    @search = Idea.new

    if (params[:idea])
      @search = Idea.new(idea_params)

      if @search.location_categories.size > 0
        @ideas = @ideas.includes(:location_categories).where('location_categories.id IN (?)', @search.location_category_ids)
      end
      if @search.method_categories.size > 0
        @ideas = @ideas.includes(:method_categories).where('method_categories.id IN (?)', @search.method_category_ids)
      end
      if @search.activity_categories.size > 0
        @ideas = @ideas.includes(:activity_categories).where('activity_categories.id IN (?)', @search.activity_category_ids)
      end
      if @search.season_categories.size > 0
        @ideas = @ideas.includes(:season_categories).where('season_categories.id IN (?)', @search.season_category_ids)
      end

      if @search.title
        @ideas = @ideas.where("LOWER(title) LIKE ?", '%'+@search.title.downcase+'%')
      end

      if @search.material
        @ideas = @ideas.where("LOWER(material) LIKE ?", '%'+@search.material.downcase+'%')
      end

      @ideas = @ideas.where('age_min <= ? AND age_max >= ?', @search.age_max, @search.age_min)
      @ideas = @ideas.where('group_size_min <= ? AND group_size_max >= ?', @search.group_size_max, @search.group_size_min)
    end
  end
end
