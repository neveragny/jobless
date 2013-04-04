class Employees::ListingsController < EmployeesController
  before_filter :authenticate_user!, :only => [:my_listings]

  def index
    @listings = Listing.all

  end

  def my_listings
    @listings = current_user.listings
  end

  def create
    if user_signed_in?
      @listing = current_employee.listings.build( params[:listing])
      if @listing.save
        flash[:notice] = I18n.t('listings.created')
      end
      redirect_to root_url
    else
      @employee = Employee.new(:email => params[:listing][:email], :password => "p@ssword", :password_confirmation => "p@ssword" )
      if @employee.save
        Rails.logger.debug params
        @listing = @employee.listings.build(params[:listing])
        if @listing.save
          flash[:notice] = I18n.t('listings.created')
          sign_in @employee
        end
      else
        flash[:notice] = @employee.errors.full_messages.first
      end
      redirect_to root_url
    end
  end

end