class StaticPagesController < ApplicationController

  def home
    @timestamp = Time.now.to_i.to_s
  end


  def backtoroot
    redirect_to root_url
  end


end