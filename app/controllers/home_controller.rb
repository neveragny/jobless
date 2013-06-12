class HomeController < ApplicationController
  def index
    @listing = Listing.new
    @last_listings = Listing.order('created_at DESC').limit(5)
  end
end
