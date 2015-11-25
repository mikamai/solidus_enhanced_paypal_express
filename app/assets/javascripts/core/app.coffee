module.exports = class App
  defaults:
    # Imposta il prefisso delle classi css
    # Se definisco una classe js_main in frontend priva di stili
    # effettuo una chiamata al method interno "main"
    prefix: "js_"
    onInit: () ->

  ###
   Public Methods
  ###

  main: ->

  # Initialize
  _initialize: ->
    # Section
    section = @el.attr('class')?.split(' ')
    # Call method on class base
    $(section).each (index, classe) =>
      if classe.indexOf(@options.prefix) == 0
        classe = classe.substring(@options.prefix.length)
        @[classe]?.call?(@)

    # Set toggler Navigation
    $(".js-nav-toggler").on "click", (e) ->
      e.preventDefault()
      $("body").toggleClass("open")

    # Set toggler World
    $(".js-world-toggler").on "click", (e) ->
      e.preventDefault()
      $(".nav-languages__list").toggleClass("open")

    $(window).load =>
      @_center_object(".wrapper-entry-page")
    $(window).resize =>
      @_center_object(".wrapper-entry-page")

  # auto vertical center entry page box
  _center_object:(selector) ->
    nh=($(window).height()-$(selector).height())/2
    nw=($(window).width()-$(selector).width())/2
    console.log(nh, nw)
    $(selector).css
      "top":nh
      "left":nw


  # Microtemplate
  _t:(s,d) ->
    for p of d
      s = s.replace(new RegExp("{#{p}}","g"), d[p])
    s

  #
  # Constructor class
  constructor: (el, options) ->
    # Set options
    @options = $.extend({}, @defaults, options )
    @el = $(el)
    do @_initialize
    @
