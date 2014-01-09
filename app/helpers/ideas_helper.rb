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

  def filterUnpublishedIdeas
    at = Idea.arel_table
    @ideas = @ideas.where(at[:published].eq(true).or(at[:user_id].eq(current_user.id)))
  end


  def filterIdeas
    @filter = Filter.new

    if (params[:filter])
      @filter = Filter.new(filter_params)

      # text filter
      if @filter.title != ''
        @ideas = @ideas.where("LOWER(title) LIKE ?", ls(@filter.title))
      end

      if @filter.material != ''
        @ideas = @ideas.where("LOWER(material) LIKE ?", ls(@filter.material))
      end

      if @filter.content != ''
        @ideas = @ideas.where("LOWER(start) LIKE ? OR LOWER(main_part) LIKE ? OR LOWER(end) LIKE ?", ls(@filter.content), ls(@filter.content), ls(@filter.content))
      end

      # associations filter
      if @filter.method_category_ids.size > 1
        @ideas = @ideas.includes(:method_categories).where('method_categories.id IN (?)', @filter.method_category_ids)
      end
      if @filter.location_category_ids.size > 1
        @ideas = @ideas.includes(:location_categories).where('location_categories.id IN (?)', @filter.location_category_ids)
      end
      if @filter.activity_category_ids.size > 1
        @ideas = @ideas.includes(:activity_categories).where('activity_categories.id IN (?)', @filter.activity_category_ids)
      end
      if @filter.season_category_ids.size > 1
        @ideas = @ideas.includes(:season_categories).where('season_categories.id IN (?)', @filter.season_category_ids)
      end

      # range filter
      if @filter.age_min && @filter.age_max
        @ideas = @ideas.where('age_min <= ? AND age_max >= ?', @filter.age_max, @filter.age_min)
      end
      if @filter.group_size_min && @filter.group_size_max
        @ideas = @ideas.where('group_size_min <= ? AND group_size_max >= ?', @filter.group_size_max, @filter.group_size_min)
      end
    end
  end

  def ls (text)
    '%'+text.downcase+'%'
  end

  def filter_params
    params.require(:filter).permit(:title,
                                   :material,
                                   :content,
                                   :group_size_min,
                                   :group_size_max,
                                   :age_min,
                                   :age_max,
                                   method_category_ids: [],
                                   activity_category_ids: [],
                                   season_category_ids: [],
                                   location_category_ids: [])
  end
end
