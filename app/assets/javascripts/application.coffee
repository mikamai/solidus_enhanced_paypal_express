#= require jquery
#= require jquery_ujs
#= require spree
#= require_tree ./spree_custom/
#= require vendor/privacy
#= require spree/backend/spree_braintree_vzero
#= require spree/frontend/spree_braintree_vzero

require 'core/plugin'
App = require 'core/app'
Coverized = require 'vendor/coverized'
Cookies = require 'js-cookie'

$(document).on 'page:change ready', (event) ->
  # idempotent function
  # -> function that applied more than one time does not wreck everything
  new App "div.controller"
  new Coverized ".coverized", {}

  text = "La direttiva europea 2009/136/CE (E-Privacy) regola l'utilizzo dei cookie, che vengono utilizzati anche su questo sito! Acconsenti continuando con la navigazione o facendo un clic su \"OK\". <a target=\"_blank\" href=\"http://www.youronlinechoices.com/it/\">Ulteriori informazioni</a>"

  new Privacy({
    "btn_text": "ok"
    "template_text": text
    "link": "/privacy-policy"
    "safe_paths": ["/privacy-policy"]
    "position": "bottom"
    "opt_cookie": {}
    "domain": 'DA INSERIRE'
    "onWriteTracking": ->
      if Cookies.get('set_ga_accepted') && Cookies.get('set_ga_accepted') == "true"
       window.ga ||= () -> null
       ga('create', 'UA-XXXXXX-X', 'auto')
       ga('send', 'pageview')
  })
  true
