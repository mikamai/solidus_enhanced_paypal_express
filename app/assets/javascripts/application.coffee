#= require jquery
#= require jquery_ujs
#= require turbolinks
require 'core/plugin'
App = require 'core/app'
Coverized = require 'vendor/coverized'

$(document).on 'page:change', (event) ->
  # idempotent function
  # -> function that applied more than one time does not wreck everything
  new App "div.controller"
  new Coverized ".coverized", {}
