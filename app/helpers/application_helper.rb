module ApplicationHelper
  def alert_class(flash_key)
    if flash_key == :notice
      'alert-success'
    else
      "alert-#{flash_key}"
    end
  end
end

