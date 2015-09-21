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
    
jQuery(document).on "page:change", ()->
  jQuery('.phone-number-check-mod-page').on 'click', '.send-code-btn', ->
    if (jQuery('.send-code-btn').attr('disabled'))== undefined
      phone_num = jQuery('.form-send-validation-request input').val()
      if phone_num == ''
        alert('请输入11位手机号')
      else
        jQuery.ajax({
          url:'/messages',
          type:'POST',
          data: {
            'message[phone_num]': phone_num
          }
          success: (res) ->
            console.log(res)
            jQuery('.return_message').empty()
            json_obj_prase = JSON.stringify(res)
            jQuery("<p>"+json_obj_prase+"</p>").prependTo('.return_message')
            jQuery('.phone-number-check-mod-page .hidden-phone-num').find('input').val(phone_num)
            jQuery('.form-send-validation-request input').val(phone_num)
            countdown(10)
        })

  jQuery('.phone-number-check-mod-page').on 'click', '.submit-btn', ->
    phone_num = jQuery('.phone-number-check-mod-page .hidden-phone-num').find('input').val()
    valid_code =jQuery('.phone-number-check-mod-page').find('.validation_input').val()
    console.log(phone_num)
    console.log(valid_code)
    jQuery.ajax({
      url:'/messages/check_validation',
      type:'POST',
      data: {
        'phone_num': phone_num
        'valid_code':valid_code
      }
      success: (res) ->
        console.log(res)
        })


