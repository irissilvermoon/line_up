class ApplicationController < ActionController::Base
  protect_from_forgery

  layout->(controller) {
    if controller.request.xhr?
      nil
    else
      'application'
    end
  }
end
