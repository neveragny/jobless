class EmployeesController < ApplicationController
  before_filter :authenticate_user!, :only => [:set_password, :messages, :mark_as_read]

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

  def send_message
      if params[:contact_message][:contact_id]
        @employee = Employee.find(params[:contact_message][:contact_id])
        @message = @employee.messages.build :from_email => params[:contact_message][:from_email], :body => params[:contact_message][:body], :read => true
        if @message.save
          flash[:notice] = I18n.t("listings.message_suc_sent")
        else
          flash[:notice] = @message.errors.full_messages.first
        end
      end
      redirect_to listings_path
  end

  def messages
    @messages = current_user.messages
  end

  def mark_as_read
    message = current_user.messages.where(:id => params[:message_id]).first
    Rails.logger.debug message.from_email

    Rails.logger.debug request.xhr?
    render :nothing => true
  end

end
