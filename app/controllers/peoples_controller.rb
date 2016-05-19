class PeoplesController < ApplicationController
  def show
    flash[:message] = params[:id]
  end
end
