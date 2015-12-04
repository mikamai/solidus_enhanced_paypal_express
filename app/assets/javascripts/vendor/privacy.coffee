$ = jQuery
Cookies = require 'js-cookie'

class Privacy
  defaults:
    position: "top"
    safe_paths: []
    selector: "body"
    template: '<div class="privacy-cookies"> \
                <div class="privacy-cookies-contents"> \
                  <div class="privacy-contents-left"> \
                    <p>{template_text}</p> \
                  </div> \
                  <div class="privacy-contents-right"> \
                   <button type="button">{btn_text}</button> \
                  </div> \
                </div> \
               </div>';
    btn_text: "Accetta!"
    template_text: ""
    link:"#"
    opt_cookie:
      expires: 712
      path: '/'
      domain: ''

    onInit: () ->
    onAccepted: () ->
    onClose: () ->
    onWriteTracking: () ->

  ###
   Private Methods
  ###

  # Inizializza pl
  _initialize: ->
    root = @
    html = @_t(@.options.template,
      "btn_text": @.options.btn_text
      "link": @.options.link
      "template_text": @.options.template_text
      )
    # Append
    $("body").prepend(html);
    $("div.privacy-cookies").hide().delay(200).slideDown( 400 )

    do @._setPadding

    # Behaviours
    $("div.privacy-cookies").find("button").on "click", ()=>
      do @_accept

    # Bind events to accept
    if !@._ifSafePath()
      $( window ).bind( "click.privacy, scroll.privacy", @_eventToAccept );

    $(window).on "resize", ()=>
      do @._setPadding

  _eventToAccept: (e)=>
    if( !$(e.target).data("safe-event") )
      do @_accept

  _isIE: ()->
    myNav = navigator.userAgent.toLowerCase();
    if myNav.indexOf('msie') != -1
      myNav.split('msie')[1]
    else
      false

  _remove: ()->
    $("div.privacy-cookies").css("display", "none").remove()
    do @.options.onClose

  _accept: ()->
    Cookies.set('set_ga_accepted', 'true', @.options.opt_cookie);
    Cookies.set('set_cookie_accepted', 'true', @.options.opt_cookie);
    $( window ).unbind( "click.privacy, scroll.privacy", @_eventToAccept );
    do @.options.onWriteTracking
    do @._removePadding
    do @.options.onAccepted

    if ! do @_isIE
      $("div.privacy-cookies").slideToggle( 400, ()=>
        do @_remove
      )
    else
      do @_remove

  _ifSafePath: () ->
    $.inArray( window.location.pathname, @.options.safe_paths) == 0 ? false : true

  _setPadding: () ->
    $(@.options.selector).css(
      "padding-#{@options.position}", $("div.privacy-cookies").height()
    )
    $("div.privacy-cookies").css("#{@options.position}", 0);

  _removePadding: () ->
    $(@.options.selector).css(
      "padding-#{@options.position}", ""
    )


  # Microtemplate
  _t:(s,d) ->
    for p of d
      s = s.replace(new RegExp('{' + p + '}','g'), d[p])
    s

  #
  # Constructor class
  constructor: (options) ->

    if window.console == undefined
      window.console = () ->
        return

    # Set options
    @options = $.extend({}, @defaults, options )

    # Init pl
    # Verifica se è settato il cookie
    if( !Cookies.get('set_ga_accepted') || !Cookies.get('set_cookie_accepted') )
      # Verifica se il referrer è vuoto o diverso dal dominio sul quale risiede
      if( document.referrer == "" || !document.referrer.indexOf(document.domain))
        do @_initialize
        # Init
        do @.options.onInit

      else
        if !@._ifSafePath()
          # l'utente proviene da una pagina del dominio e ha approvato implicitamente l'informativa continuando la navigazione
          do @_accept
        else
          console.log "Safe url"
    else
      # Accepted cookie
      do @.options.onWriteTracking

    @


window.Privacy = Privacy
