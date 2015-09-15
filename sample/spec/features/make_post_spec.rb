require 'rails_helper'

describe "发验证码", :type => :feature do
  it '点击发送' do
    visit '/messages/new'
    num = '15901137853'
    fill_in 'phone_num', :with => num
    expect(page).to have_content '输入验证码'
    # find_link('.btn').click
    # click_link 'send'
    # click_link('send-code')
    # click_link('#send-code')
    # click_link 'send-code'
    # click_on 'send'
  end
end

