class HomeController < ApplicationController
  def index
    @listing = Listing.new
    @last_listings = Listing.order('created_at').limit(5)
  end
end
