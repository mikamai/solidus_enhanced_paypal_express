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
