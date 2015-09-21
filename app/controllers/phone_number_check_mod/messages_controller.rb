
module PhoneNumberCheckMod
  class MessagesController < PhoneNumberCheckMod::ApplicationController
    require 'digest'
    require 'uri'
    require 'net/http'
    require 'net/https'

    def new
    end

    def create
      phone_num = params[:message][:phone_num]
      post = PhoneMessageValid.new(phone_num) 
      valid_info = post.valid
      if valid_info.success?
        Message.create(:phone_num=> valid_info.phone_num ,:valid_code => valid_info.valid_code)
        render :status => 200,  :json => {:post_result=>'success'}.to_json
      else
        render :status => 200,  :json => {:post_result=>'failed'}.to_json
      end
    end

    def check_validation
      if  PhoneNumberCheckMod::Message.where(:phone_num=>params[:phone_num],:valid_code => params[:valid_code]).blank?
        render :status => 200,  :json =>{:validation_result=>'incorrect'}.to_json
      else
        render :status => 200,  :json =>{:validation_result=>'correct'}.to_json
      end
    end
  end
end
