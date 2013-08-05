module TimeHelper
  def display_time(time)
    time.to_s(:club_time) if time
  end
end