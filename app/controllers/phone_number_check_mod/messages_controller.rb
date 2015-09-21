
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
      # 使用步骤 一：传入手机号码
      post = PhoneMessageValid.new(phone_num) 
      # 使用步骤 二：从新建立的实例里能取得实例方法 success？ 和valids 返回 1请求是否成功 2请求返回信息（json转字符串）
      valid_info = post.valid
      if valid_info.success?
      # 使用步骤 三：如果请求成功，则通过返回信息生成可查询的验证表
        Message.create(:phone_num=> valid_info.phone_num ,:valid_code => valid_info.valid_code)
      end
      # render 一个json
      render :status => 200,  :json => valid_info.response_json
    end

    def check_validation
      p params[:phone_num].class
      p params[:valid_code].class
      # 使用步骤 四：可以得到用户的输入并且比对再进行处理
      if  PhoneNumberCheckMod::Message.where(:phone_num=>params[:phone_num],:valid_code => params[:valid_code]).blank?
        render :status => 200,  :json =>{:validation_result=>'incorrect'}.to_json
      else
        render :status => 200,  :json =>{:validation_result=>'correct'}.to_json
      end
    end
  end
end
