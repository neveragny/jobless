class EmployeesController < ApplicationController
  before_filter :authenticate_user!

  def set_password
    if current_user
      @employee = Employee.find(current_user)
      @employee.password = params[:password]["password"]
      @employee.password_confirmation = params[:password]["password"]
      @employee.sign_in_count = 2
      if @employee.save
        sign_in(@employee, :bypass => true)
        flash[:notice] = I18n.t("common.password_updated")
      else
        flash[:notice] = @employee.errors.full_messages.first
      end
    end
    redirect_to root_url
  end
end
