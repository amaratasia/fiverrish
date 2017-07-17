class PagesController < ApplicationController
  def home
  	@gigs = Service.order('id desc').limit(4)
  end
end
