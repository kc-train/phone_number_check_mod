module PhoneNumberCheckMod
  class ApplicationController < ActionController::Base
    layout "phone_number_check_mod/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end