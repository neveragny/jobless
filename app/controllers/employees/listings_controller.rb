class Employees::ListingsController < EmployeesController
  before_filter :authenticate_user!, :only => [:my_listings, :edit]

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
      else
        flash[:error] = @listing.errors.full_messages.first
      end
      redirect_to root_url
    else
      @employee = Employee.new(:email => params[:listing][:email], :password => "p@ssword", :password_confirmation => "p@ssword" )
      if @employee.save
        #Rails.logger.debug params
        @listing = @employee.listings.build(params[:listing])
        if @listing.save
          flash[:notice] = I18n.t('listings.created')
          sign_in @employee
        else
          flash[:error] = @listing.errors.full_messages.first
        end
      else
        if @employee
          flash[:error] = @employee.errors.full_messages.first
        end
      end
      redirect_to root_url
    end
  end

  def edit
    @listing = current_user.listings.find(params[:id])
    #TODO redirect to my_listings_path if nil (now throwing exception)
    redirect_to my_listings_path, :error => "An error has been occured" if @listing.nil?
    #TODO translate errors, fix messaging

  end

  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update_attributes(params[:listing])
      redirect_to my_listings_path, :notice => I18n.t("flash.notice.listing_has_been_updated")
    else
      redirect_to edit_listing_path(@listing), :error => "an error has been occured"
      #TODO sort out with validation errors to be shown after failed update
    end
  end

end