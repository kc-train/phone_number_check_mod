require 'rails_helper'

RSpec.describe User, type: :model do
  # describe "举例" do
  #   it{
  #     expect(create(:user).name).to eq("tom")
  #   }
  # end

  describe "测试发验证码" do
    it{
      post = PhoneNumberCheckMod::PostRequest.new("15901137853")
      res = post.request
    }
  end
end
