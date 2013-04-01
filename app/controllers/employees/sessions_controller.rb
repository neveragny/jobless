class Employees::SessionsController < Devise::SessionsController

  skip_before_filter :require_user_details!

  def create
    sign_out :employer if employer_signed_in?
    super
  end

end