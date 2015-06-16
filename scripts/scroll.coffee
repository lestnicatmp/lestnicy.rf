class ScrollModule

  # General

  run: =>
    hash = $(location).attr('hash')
    if hash
      @scroll(hash)
    $('a[href^="#"]').click(@on_click)

  # Bindings

  on_click: (event) =>
    event.preventDefault()
    element = event.currentTarget
    hash = $(element).attr('href').replace('/', '')
    @scroll(hash)

  # Helpers

  scroll: (hash) =>
    element = $(hash)
    if element.length
      if element.is(':hidden')
        element.parents('.uk-switcher').children().removeClass('uk-active')
        element.parents('.uk-switcher>li').addClass('uk-active')
      offset = $('.header').height() + 20
      UIkit.Utils.scrollToElement(element, {offset: offset})
