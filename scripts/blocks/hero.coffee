class HeroModule

  # General

  run: =>
    @thumbnails = $('.hero-thumbnail')
    if @thumbnails.length
      @interval = setInterval(@on_interval, 5000)
      @thumbnails.click(@on_thumbnail_click)

  # Bindings

  on_thumbnail_click: (event, auto=false) =>
    if not auto
      clearInterval(@interval)
    event.preventDefault
    active = 'hero-thumbnail--active'
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
    current = $('.hero-thumbnail--active')
    next = current.next()
    if not next.length
      next = current.siblings().first()
    next.trigger('click', [true])
