$ ->
  $('#order_use_billing').on 'change', (event) ->
    $this = $(this)
    is_checked = $this.is(':checked')
    fieldset_tag = $this.parents('fieldset')
    fieldset_tag.find('input,select').not(this).prop('disabled',is_checked)
    fieldset_tag.find('.field, .form-field').not('.js-use-billing-checkbox').css(
      color: if is_checked  then 'grey' else ''
    )
  .trigger('change')

  $('#order_bill_address_attributes_country_id').on 'change', (event) ->
    $this = $(this)
    setOptions = (options) ->
      if options
        $("#order_bill_address_attributes_state_id").append(options)
      else
        $("#order_bill_address_attributes_state_id").hide()
    $.get '/state_from_country', {'id': $this.val()}, setOptions
