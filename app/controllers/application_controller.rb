class ApplicationController < ActionController::Base
  #include Searchable::HelperMethods

  clear_helpers

  protect_from_forgery

  before_filter :devise_prefixes
  #before_filter :employee_news
  #before_filter :employer_news
  #before_filter :require_password_reset!

  helper_method :render_not_found, :render_permission_denied, :current_user, :user_signed_in?, :current_company

  def current_user # current_employee or current_employer
    if user_signed_in?
      current_employee || current_employer
    end
  end

  def current_company
    @current_company ||= employer_signed_in?? Company.where(id: current_employer.company_id).includes(:company_details).first : nil
  end

  def user_signed_in?
    employee_signed_in? or employer_signed_in?
  end

  def set_current_user
    if current_user && current_user.respond_to?(:current)
      Object.const_get(current_user.class.name).current = current_user
    end
  end

  def authenticate_user!
    render_authentication_required unless employee_signed_in? or employer_signed_in?
  end

  def render_not_found
    request.xhr? ? render(text: I18n.t('common.not_found')) : redirect_to(root_path, alert: I18n.t('common.not_found'))
  end

  def render_permission_denied
    request.xhr? ? render(text: I18n.t('common.permission_denied')) : redirect_to(root_path, alert: I18n.t('common.permission_denied'))
  end

  def render_authentication_required
    %w(employees employer).each { |user| session["#{user}_return_to"] = request.path }
    request.xhr? ? render(text: I18n.t('common.please_authenticate')) : redirect_to(root_path, alert: I18n.t('common.please_authenticate'))
  end

  def set_default_language
    I18n.locale = I18n.default_locale
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Employer)# && params[:controller] == "devise/confirmations" && params[:action] == "show"
      employer_dashboard_path
    else
      stored_location_for(resource) || root_path
    end
  end

  private

  def parse_sort_params(attrs = [ 'created_at' ], default_attribute = 'created_at')
    if params[:sort_attribute] and params[:sort_direction]
      attribute = attrs.include?(params[:sort_attribute]) ? params[:sort_attribute] : default_attribute
      direction = %(asc desc).include?(params[:sort_direction]) ? params[:sort_direction] : 'desc'
    else
      attribute, direction = default_attribute, 'desc'
    end

    @sort_by = "#{attribute} #{direction}"
  end


  def require_user_details!
    if user_signed_in?
      unless current_user.has_details?
        session[:details_required] = request.path
        path, flash[:info] = employer_signed_in?? [edit_employer_details_path, I18n.t('employer_details.required')] :
            [edit_employee_details_path, I18n.t('employee_details.required')]

        redirect_to path
      end
    end
  end


  def devise_prefixes
    return unless defined?(devise_mapping)
    return _prefixes unless self.class.scoped_views? and devise_mapping

    unless @_prefixes and @_prefixes.include?("#{devise_mapping.scoped_path}/devise/#{controller_name}")
      @_prefixes.unshift("#{devise_mapping.scoped_path}/devise/#{controller_name}")
    end
  end

  #def employee_news
  #  return unless employee_signed_in?
  #
  #  @new_messages = current_employee.incoming_messages.where(read: false).count
  #  @new_cv_views = current_employee.cv_views.where(seen: false).count
  #  @new_connections = current_employee.pending_employee_connections.count + current_employee.pending_employer_connections.count
  #  @new_sent_jobs = current_employee.sent_jobs.where(read: false).count
  #end
  #
  #def employer_news
  #  return unless employer_signed_in?
  #
  #  @new_sent_cvs = current_employer.sent_cvs.where(read: false).count
  #  @new_company_sent_cvs = current_company.sent_cvs.where(read: false).count
  #  @new_connections = current_employer.pending_employee_connections.count
  #  @new_messages = current_employer.incoming_messages.where(read: false).count
  #end

end