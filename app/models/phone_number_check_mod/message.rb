module PhoneNumberCheckMod
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    # 发送短信的手机号
    field :phone_num,  :type => Integer

    # 发送短信对应的验证码
    field :valid_code, :type => Integer
  end
end