countdown = (count)->
  if count > 0
    jQuery('.send-code-btn').html('重新发送('+count+')s')
    jQuery('.send-code-btn').attr('disabled', 'disabled')
    setTimeout ->
      countdown(count - 1)
    , 1000
  else
    jQuery('.send-code-btn').html('发送验证码')
    jQuery('.send-code-btn').attr('disabled', false)
    
$(document).on "page:change", ()->
  $('.phone-number-check-mod-page').on 'click', '.send-code-btn', ->
    if ($('.send-code-btn').attr('disabled'))== undefined
      phone_num = $('.form-send-validation-request input').val()
      if phone_num == ''
        alert('请输入11位手机号')
      else
        $.ajax({
          url:'/messages',
          type:'POST',
          data: {
            'message[phone_num]': phone_num
          }
          success: (res) ->
            $('.return_message').empty()
            $("<p>"+res+"</p>").prependTo('.return_message')
            $('.phone-number-check-mod-page .hidden-phone-num').find('input').val(phone_num)
            $('.form-send-validation-request input').val(phone_num)
            countdown(10)
          })



