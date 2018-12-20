# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "timezone"

# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Timelocal < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "timelocal"

  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    if !event.get('time_event').nil?
      d = DateTime.strptime(event.get('time_event').to_s, '%Q')
      z = Timezone[timezone.tr(" ", "_")]
      nd = z.nil? ? d : d.new_offset(z.abbr(d))
      event.set('time_local_hour', nd.strftime('%H'))
      event.set('time_local_weekday', nd.strftime('%u_%a'))
      event.set('time_local_timezone_offset', nd.zone)
    end
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Timelocal
