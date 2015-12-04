$ ->
  $('[name="variant_id"]').on 'change', (event) ->
    $this = $(this)

    price = $this.find("[value=#{$this.val()}]").data('price')
    if price
      $('.js-product-price').text(price)

    true
  .trigger 'change'
