require 'chronic'

class DefaultController < ApplicationController
  def parse
    @q      = (params[:q] || Time.now.utc.to_s).strip.downcase
    @offset = Integer(params[:offset] || 0)

    Chronic.time_class = ActiveSupport::TimeZone["UTC"]

    @utc      = Chronic.parse(@q)
    @valid    = !(@utc.nil?)
    @local    = @valid ? get_local_time_from_offset(@utc, @offset) : ''
    @timezone = @valid ? get_timezone_name_from_offset(@offset) : ''

    render 'parse', formats: 'json'
  end

  private

  def get_local_time_from_offset(utc, offset)
    get_timzeone_from_offset(offset).at(utc)
  end

  def get_timzeone_from_offset(offset = 0)
    ActiveSupport::TimeZone[ get_timezone_name_from_offset(offset) ]
  end

  def get_timezone_name_from_offset(offset = 0)
    local_offset = 3600 * offset

    ActiveSupport::TimeZone::MAPPING.keys.find do |tz_name|
      ActiveSupport::TimeZone[tz_name].utc_offset == local_offset
    end
  end
end
