
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
      end
      render :status => 200, :text => '发送成功'
    end

    def check_validation
      if Message.where(:phone_num=>params[:phone_num], :valid_code => params[:validation]).empty?
        redirect_to "/messages/new", notice: '验证失败'
      else
        render 'check_validation'
      end
    end
  end
end
