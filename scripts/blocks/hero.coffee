class HeroModule

  # General

  run: =>
    @thumbs = $('.hero-thumb')
    if @thumbs.length
      @interval = setInterval(@on_interval, 5000)
      @thumbs.click(@on_thumb_click)

  # Bindings

  on_thumb_click: (event, auto=false) =>
    if not auto
      clearInterval(@interval)
    event.preventDefault
    active = 'hero-thumb--active'
    element = $(event.currentTarget)
    element.siblings().removeClass(active)
    element.addClass(active)
    target = $('.hero-figure')
    target.stop()
    target.fadeOut 'fast', =>
      target.find('.hero-image').attr('src', element.data('image'))
      target.find('.hero-link').attr('href', element.data('link'))
      target.find('.hero-link-name').html(element.data('name'))
      target.find('.hero-price-value').html(element.data('price'))
      target.fadeIn(1000)

  on_interval: =>
    current = $('.hero-thumb--active')
    next = current.next()
    if not next.length
      next = current.siblings().first()
    next.trigger('click', [true])
