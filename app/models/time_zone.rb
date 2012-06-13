class TimeZone < ActiveRecord::Base
  attr_accessible :abbreviation, :dst, :gmt_offset, :time_start
end
