date_formats = {
  # :clean         => "%d %b %Y",   # 21 Feb 2008
  # :short         => "%b %d"       # Feb 21
}
time_formats = {
  # :time          => "%l:%M%p"     # 03:24PM
}
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.update(date_formats)
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(date_formats)
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(time_formats)
