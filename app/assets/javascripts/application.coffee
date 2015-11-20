#= require jquery
#= require jquery_ujs
#= require turbolinks
require 'core/plugin'
App = require 'core/app'
Coverized = require 'vendor/coverized'

$(document).on 'ready', (event) ->
  # initialize persistent state

$(document).on 'ready page:load', (event) ->
  # apply non-idempotent transformations to the body
  # -> function that, if applied more than one time, wrecks everything
  new App "div.controller"
  new Coverized ".coverized", {}

$(document).on 'page:change', (event) ->
  # idempotent function
  # -> function that applied more than one time does not wreck everything
