class HomeModule

  # General

  layouts: ['home']

  run: =>
    @collect()
    @bind()
    if @hash
      @scroll_to_element(@hash)

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

  # Helpers

  scroll_to_element: (selector, duration) =>
    offset = $('main').offset().top - 1
    duration = duration or 500
    $('html, body').animate({
      scrollTop: $(selector).offset().top - offset
    }, duration)

