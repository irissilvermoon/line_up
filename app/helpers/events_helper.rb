module EventsHelper
  def display_date(date)
    date.to_s(:event_date) if date
  end
end
