module PhoneNumberCheckMod
  class << self
    def set_admin_information(account,token)
      PhoneNumberCheckMod::PhoneMessageValid.set_accountsid(account)
      PhoneNumberCheckMod::PhoneMessageValid.set_authtoken(token)
    end 
    def set_base_url(url)
      PhoneNumberCheckMod::PhoneMessageValid.set_base_url(url)
    end
    def set_app_id(id)
      PhoneNumberCheckMod::PhoneMessageValid.set_app_id(id)
    end
  end
end
require 'phone_number_check_mod/engine'
require 'phone_number_check_mod/phone_message_valid'
