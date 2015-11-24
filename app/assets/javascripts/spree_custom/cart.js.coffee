Spree.ajax
  url: Spree.pathFor("cart_link"),
  success: (data) ->
    $ ->
      $('.js-inject-link-to-cart').html data
