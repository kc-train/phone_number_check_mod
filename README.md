# PhoneNumberCheckMod

## 介绍

phone_number_check_mod 可以对容联云通讯短信平台发起请求，生成验证码，如果短信把验证码发送成功则可以通过返回的信息进行确认再做进一步处理。

## 安装

../Gemfile:

```ruby
gem 'phone_number_check_mod', 
  :github => 'kc-train/phone_number_check_mod',
  :tag => 0.0.1
```

运行命令:
```
    $ bundle
    $ gem install phone_number_check_mod
```   
## 配置文件

../Gemfile
```ruby
gem 'figaro'  
```

安装
```
$ bundle
```
创建这个文件：
../config/initializers/initialize_validation_account.rb
```ruby
PhoneNumberCheckMod.set_admin_information(ENV['account'],ENV['token'])
PhoneNumberCheckMod.set_base_url(ENV['base_url'])
```
../config/application.yml
```ymal
ACCOUNT: "8a48b5514fac9535014fb0225e2a0679"
TOKEN: "550c13b92ef3404f85474f2ca984aef1"
BASE_URL: "https://sandboxapp.cloopen.com:8883"
APP_ID:"8a48b5514fac9535014fb0229bdd067b"
```
[容联云通讯平台](http://www.yuntongxun.com/)    

application.yml文件里的 ACCOUNT和TOKEN代表容联云通讯短信平台开发者的账号和口令。
BASE_URL 用在对短信平台发请求时候所请求的目标url，文档里使用的是开发模式下的沙箱url，正式上线后要使用其他的url，
点击链接后注册平台账号，进入'控制台首页'可以看到开发者主账号信息，例如我的是：     
ACCOUNT SID：    
8a48b5514fac9535014fb0225e2a0679   
AUTH TOKEN：   
550c13b92ef3404f85474f2ca984aef1     
(开发) Rest URL：   
https://sandboxapp.cloopen.com:8883   
(生产) Rest URL：   
https://app.cloopen.com:8883  
在用户的管理界面可以增加应用和短信模板，它们都有对应的id。
使用者根据自己开发的情况修改application.yml文件里的各种配置属性。  


../config/routes.rb
```
Rails.application.routes.draw do
  mount PhoneNumberCheckMod::Engine => '/', :as => 'phone_number_check_mod'
end
```

## 使用方法  
这个gem提供了两种rest api接口。   
发送验证码：
```
url
  /messages
method
  post
params
  phone_num # 手机号
logic
  产生一个验证码，并会在接下来的几十秒内发送验证码到 phone_num 这个手机

  #响应示例
response
  #if success
   {post_result:"success"}
  #if failure
   {post_result:"failed"}
 }  
```
验证验证码:
```
url
 /messages/check_validation
method
  post
params
  phone_num  # 手机号
  valid_code # 验证码
logic
  根据接收到的手机号和验证码，检查验证码是否正确
  #响应示例
response
  #if 正确
    { validation_reult : "correct" }  
  #if 错误
    { validation_reult : "incorrect" }  
```