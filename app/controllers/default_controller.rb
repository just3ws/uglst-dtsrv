require 'chronic'

class DefaultController < ApplicationController
  def parse
    @q      = (params[:q] || Time.now.utc.to_s).strip.downcase
    @offset = Integer(params[:offset] || 0)

    Chronic.time_class = ActiveSupport::TimeZone["UTC"]

    @utc      = Chronic.parse(@q)
    @local    = get_local_time_from_offset(@utc, @offset)
    @timezone = get_timezone_name_from_offset(@offset)

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
    ActiveSupport::TimeZone::MAPPING.keys.find { |tz_name|
      ActiveSupport::TimeZone[tz_name].utc_offset == 3600 * offset
    }
  end
end
