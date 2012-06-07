require 'chronic'

class DefaultController < ApplicationController
  def parse
    @q = params[:q] || Time.now.utc.to_s
    Chronic.time_class = ActiveSupport::TimeZone["UTC"]
    @utc = Chronic.parse(@q)
    render 'parse', formats: 'json'
  end
end
