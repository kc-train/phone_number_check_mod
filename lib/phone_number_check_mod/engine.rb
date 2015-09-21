module PhoneNumberCheckMod
  class Engine < ::Rails::Engine
    isolate_namespace PhoneNumberCheckMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end