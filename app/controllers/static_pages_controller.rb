class StaticPagesController < ApplicationController
  require "net/http"

  def home
    @timestamp = Time.now.to_i.to_s
    @client_ip = request.remote_ip

    url_get_city = URI("http://ip.taobao.com/service/getIpInfo.php?ip=180.173.171.92")
    @res = Net::HTTP.get_response(url_get_city).body
  end


  def backtoroot
    redirect_to root_url
  end


end