Rails.application.routes.draw do
  mount PhoneNumberCheckMod::Engine => '/', :as => 'phone_number_check_mod'
  mount PlayAuth::Engine => '/auth', :as => :auth
end
