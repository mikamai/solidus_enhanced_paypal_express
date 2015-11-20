module.exports = class Coverized
  defaults:
    selector: "img.coverized"

  #
  # Constructor class
  constructor: (selector, options) ->
    # Set options
    @options = $.extend({}, @defaults, options )

    $ =>
      $(selector).each (i,e) =>
        $(e).hide()

        # fix
        didLoad = $(e)[0].complete

        load = (e, __this)=>
          $(e).data("original-width", $(e).width())
          $(e).data("original-height", $(e).height())
          # Loaded
          url = $(e).attr("src")
          console.log "%c Load #{url}", "color:#0A0"

          @_scale(e)
          $(e).fadeIn( $(e).data("fade-time") || 'slow' )

          $(window).on "resize", =>
            if window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame
              window.requestAnimationFrame( () ->
                __this._scale(e)
              )
            else
              __this._scale(e)

        if didLoad
          load $(e), @
        else
          $(e).on "load", =>
            load $(e), @

  ###
   Private Methods
  ###

  _align: (sizes, align)->
    cc = align.split(" ")

    # Vertical align
    switch cc[0]
      when "top" then top = 0
      when "bottom" then top = Math.floor(sizes.target_height - sizes.height)
      else top = Math.floor((sizes.target_height - sizes.height) / 2)

    # Horizontal align
    switch cc[1]
      when "left" then left = 0
      when "right" then left = Math.floor(sizes.target_width - sizes.width)
      else left = Math.floor((sizes.target_width - sizes.width) / 2)

    result =
      top: top
      left: left

  _scale: (element)->
    parent       = $(element).parents($(element).data("parent")) || $(element).parent()
    console.log $(element).data("parent")
    targetwidth  = $(parent).width()
    targetheight = $(parent).height()
    srcwidth     = $(element).data("original-width")
    srcheight    = $(element).data("original-height")

    # Setup data
    cover = false || $(element).data("fit")
    align = $(element).data("align") || "center center"

    result =
      width: 0
      height: 0
      fScaleToTargetWidth: true

    if srcwidth <= 0 || srcheight <= 0 || targetwidth <= 0 || targetheight <= 0
      return result

    # scale to the target width
    scaleX1 = targetwidth;
    scaleY1 = (srcheight * targetwidth) / srcwidth

    # scale to the target height
    scaleX2 = (srcwidth * targetheight) / srcheight
    scaleY2 = targetheight;

    # now figure out which one we should use
    fScaleOnWidth = (scaleX2 > targetwidth)
    if fScaleOnWidth
      fScaleOnWidth = !cover
    else
      fScaleOnWidth = cover

    if fScaleOnWidth
      result =
        width: Math.floor(scaleX1)
        height: Math.floor(scaleY1)
    else
      result =
        width: Math.floor(scaleX2)
        height: Math.floor(scaleY2)

    sizes =
      "target_width": targetwidth
      "target_height": targetheight
      "width": result.width
      "height": result.height

    ralign = @_align(sizes, align)

    $.extend( result, ralign );

    $(element).css( result )
