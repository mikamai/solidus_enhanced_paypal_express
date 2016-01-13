$ ->
  $('.js-remove-from-cart').one 'click', (event) ->
    event.preventDefault()
    $this = $(this)
    $this.attr('disabled', true)
    
    item_quantity_input = $this.parents('.table-cart__item').first().find('.js-remove-from-cart__quantity')
    item_quantity_input.val(0)

    item_form = $this.parents('form').first()
    item_form.submit()
    false

  $('.js-cart-update').one 'click', (event) ->
    event.preventDefault()
    $(this).attr('disabled', true)
    $('.js-cart-form').submit()
    false

  $('.js-cart-checkout').one 'click', (event) ->
    event.preventDefault()
    $(this).attr('disabled', true)
    $('.js-cart-form').append('<input type="hidden" name="checkout" value="true" />')
    $('.js-cart-form').submit()
    false

