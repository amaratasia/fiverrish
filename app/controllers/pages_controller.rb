class PagesController < ApplicationController
  def home
  	@gigs = Service.limit(4).order('id desc')
  end
end
