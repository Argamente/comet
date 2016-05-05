class StaticPagesController < ApplicationController

  def home
    @timestamp = Time.now.to_i.to_s
  end


end