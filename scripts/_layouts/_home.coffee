class HomeModule

  # General

  layouts: ['home']

  run: =>
    @collect()
    @bind()
    if @hash
      @scroll_to_element(@hash)
    @showcase_interval = setInterval( @on_showcase_interval, 3000)

  collect: =>
    @hash = $(location).attr('hash')
    @menuItems = $('#page-menu').find('a')
    @scrollItems = @menuItems.map (index, value) =>
      element = $(value)
      item = $(element.attr('href').replace('/', ''))
      if item.length
        return item

  bind: =>
    $(window).scroll(@on_window_scroll)
    $('#page-menu a').click(@on_page_menu_click)
    $('.argument-main .preview img').click(@on_preview_image_click)

  # Bindings

  on_window_scroll: (event)  =>
    element = $(event.currentTarget)
    # Get container scroll position
    offset = $('main').offset().top + 100
    fromTop = element.scrollTop()+offset
    # Get id of current scroll item
    cur = @scrollItems.map (index, value) =>
      element = $(value)
      if element.offset().top < fromTop
        return element
    # Get the id of the current element
    cur = cur[cur.length-1]
    id = cur and if cur.length then cur[0].id else ''
    # Set/remove active class
    @menuItems.parent().removeClass('active')
    @menuItems.filter("[href='/##{id}']").parent().addClass('active')

  on_page_menu_click: (event) =>
    element = event.currentTarget
    hash = $(element).attr('href').replace('/', '')
    @scroll_to_element(hash)
    return false

  on_preview_image_click: (event, auto=false) =>
    if not auto
      clearInterval(@showcase_interval)
    element = $(event.currentTarget)
    element.siblings().removeClass('active')
    element.addClass('active')
    showcase_image = element.data('showcase-image')
    $('img.showcase').stop()
    $('img.showcase').fadeOut 'fast', =>
      $('img.showcase').attr('src', showcase_image)
      $('img.showcase').fadeIn(1000)
    return false

  on_showcase_interval: =>
    current = $('.preview .active')
    next = current.next()
    if not next.length
      next = current.siblings().first()
    next.trigger('click', [true])

  # Helpers

  scroll_to_element: (selector, duration) =>
    offset = $('main').offset().top - 1
    duration = duration or 500
    $('html, body').animate({
      scrollTop: $(selector).offset().top - offset
    }, duration)

