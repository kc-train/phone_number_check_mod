countdown = (count)->
  if count > 0
    jQuery('.send-code-btn').html(count+'s后重新发送验证码')
    jQuery('.send-code-btn').attr('disabled', 'disabled')
    setTimeout ->
      countdown(count - 1)
    , 1000
  else
    jQuery('.send-code-btn').html('发送验证码')
    jQuery('.send-code-btn').attr('disabled', false)
    
$(document).on "page:change", ->
  $('.phone-number-check-mod-page').on 'click', '.send-code-btn', ->
    console.log 1
    phone_num = $('.form-send-validation-request input').val()

    if phone_num == ''
      console.log('请输入11位手机号')
    else
      $.ajax({
        url:'/messages',
        type:'POST',
        data: {
          'message[phone_num]': phone_num
        }
        success: (res) ->
          console.log res
          $("<p>"+res+"</p>").prependTo('.return_message')
          $('.phone-number-check-mod-page .hidden-phone-num').find('input').val(phone_num)
          $('.form-send-validation-request input').val(phone_num)
          countdown(10)
        })



