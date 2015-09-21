# PhoneNumberCheckMod

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phone_number_check_mod', 
  :github => 'mindpin/play_auth',
  :tag => 0.0.1
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phone_number_check_mod

## 介绍

phone_number_check_mod 可以对容联云通讯短信平台发起请求，生成验证码，如果短信把验证码发送成功则可以通过返回的信息进行确认再做进一步的处理。   
## 配置文件

../Gemfile
```ruby
gem 'figaro'  
```

安装
$ bundle

创建这个文件：
../config/initializers/initialize_validation_account.rb
```ruby
PhoneNumberCheckMod.set_admin_information(ENV['account'],ENV['token'])
PhoneNumberCheckMod.set_base_url(ENV['base_url'])
```
../config/application.yml
```ymal
account: "8a48b5514fac9535014fb0225e2a0679"
token: "550c13b92ef3404f85474f2ca984aef1"
base_url: "https://sandboxapp.cloopen.com:8883"
```
[容联云通讯平台](http://www.yuntongxun.com/)
ymal里的 account和token代表容联云通讯短信平台开发者的账号和口令。
base_url 用在对短信平台发请求时候所请求的目标url，文档里使用的是开发模式下的沙箱url，正式上线后要使用其他的url，
点击链接后注册平台账号，进入'控制台首页'可以看到开发者主账号信息，例如我的是：  
ACCOUNT SID：
8a48b5514fac9535014fb0225e2a0679
AUTH TOKEN：
550c13b92ef3404f85474f2ca984aef1  
(开发) Rest URL：
https://sandboxapp.cloopen.com:8883
(生产) Rest URL：
https://app.cloopen.com:8883

## 如何使用
###### 使用步骤 一：传入手机号码。
```ruby
post = PhoneMessageValid.new(phone_num) 
```
######  使用步骤 二：从新建立的实例里能取得实例方法 success？ 和valids 返回 1请求是否成功 2请求返回信息（json转字符串），如果请求成功，则通过返回信息生成可查询的验证表。
```ruby
valid_info = post.valid
  if valid_info.success?
    Message.create(:phone_num=> valid_info.phone_num ,:valid_code => valid_info.valid_code)
```
######  使用步骤 三：可以得到用户的输入并且比对再进行处理。
```ruby
  if PhoneNumberCheckMod::Message.where(:phone_num=>params[:phone_num],:valid_code => params[:valid_code]).blank?
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/phone_number_check_mod/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
