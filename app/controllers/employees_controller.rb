class EmployeesController < ApplicationController
  before_filter :authenticate_user!

  def set_password
  	if current_user
  		current_user.password = params[:password]["password"]
  		current_user.password_confirmation = params[:password]["password"]
  		current_user.sign_in_count = 2
  		if current_user.save
  			sign_in current_user
  		end
  	end
  	redirect_to root_url
  end
end