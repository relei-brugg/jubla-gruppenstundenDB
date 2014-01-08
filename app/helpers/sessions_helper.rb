module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user_id)
    signed_in? && User.find(user_id) == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def idea_owner? (idea_id)
    signed_in? && Idea.find(idea_id).user_id == current_user.id
  end

  def moderator?
    signed_in? && current_user.moderator?
  end

  def admin?
    signed_in? && current_user.admin?
  end

  # Before filters
  def signed_in_user
    unless signed_in?
      store_location
      flash[:warning] = 'Please sign in.'
      redirect_to signin_url
    end
  end

  def idea_owner
    unless idea_owner? (params[:id])
      flash[:warning] = 'Not your Idea'
      redirect_to(ideas_path)
    end
  end

  def user_owner
    unless current_user?(params[:id])
      flash[:warning] = 'Not your User'
      redirect_to(root_url)
    end
  end

  def moderator_user
    if !moderator?
      flash[:warning] = 'Not moderator'
      redirect_to(root_url)
    end
  end

  def admin_user
    if !admin?
      flash[:warning] = 'Not admin'
      redirect_to(root_url)
    end
  end
end
