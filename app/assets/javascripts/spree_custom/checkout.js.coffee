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
    $select = $("#order_bill_address_attributes_state_id")
    $text = $("#order_bill_address_attributes_state_name")
    setOptions = (options) ->
      if options
        $select.append(options)
        $select.prop("disabled", false)
        $select.removeClass("hidden").addClass("required")

        $text.prop("disabled", true)
        $text.addClass("hidden").removeClass("required")
      else
        $select.prop("disabled", true)
        $select.find('option').remove().end()
        $select.addClass("hidden").removeClass("required")

        $text.prop("disabled", false)
        $text.removeClass("hidden").addClass("required")
    $.get '/state_from_country', {'id': $this.val()}, setOptions
  .trigger('change')

  $('#order_ship_address_attributes_country_id').on 'change', (event) ->
    $this = $(this)
    $select = $("#order_ship_address_attributes_state_id")
    $text = $("#order_ship_address_attributes_state_name")
    setOptions = (options) ->
      console.log(options)
      if options
        $select.append(options)
        $select.prop("disabled", $('#order_use_billing').is(':checked'))
        $select.removeClass("hidden").addClass("required")

        $text.prop("disabled", true)
        $text.addClass("hidden").removeClass("required")
      else
        $select.prop("disabled", true)
        $select.find('option').remove().end()
        $select.addClass("hidden").removeClass("required")

        $text.prop("disabled", false)
        $text.removeClass("hidden").addClass("required")
    $.get '/state_from_country', {'id': $this.val()}, setOptions
  .trigger('change')
