require 'chronic'
require 'active_support/time'

run lambda { |env|


  date = Rack::Request.new(env).GET["date"]

  server_time = Chronic.parse(date)
  server_tz = server_time.zone

  Time.zone = "UTC"
  Chronic.time_class = Time.zone

  utc = Chronic.parse(date)

  [200, {'Content-Type'=>'application/json'}, StringIO.new("{\"utc\": \"#{utc}\"}")]
}
