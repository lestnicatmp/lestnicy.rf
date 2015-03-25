class HomeModule

  # General

  layouts: ['home']

  run: =>
    @collect()
    @bind()
    if @hash
      @scrollToElement(@hash)

  collect: =>
    @hash = $(location).attr('hash')
    @menuItems = $('#page-menu').find('a')
    @scrollItems = @menuItems.map ->
      item = $($(this).attr('href').replace('/', ''))
      if item.length
        return item

  bind: =>
    $(window).scroll(@onWindowScroll)
    $('#page-menu a').click(@onPageMenuLinkClick)

  # Bindings

  onWindowScroll: (event)  =>
    element = event.currentTarget
    # Get container scroll position
    offset = $('main').offset().top + 100
    fromTop = $(element).scrollTop()+offset
    # Get id of current scroll item
    cur = @scrollItems.map ->
      if $(this).offset().top < fromTop
        return element
    # Get the id of the current element
    cur = cur[cur.length-1]
    id = cur and if cur.length then cur[0].id else ''
    # Set/remove active class
    @menuItems.parent().removeClass('active')
    @menuItems.filter("[href='/#{id}']").parent().addClass('active')

  onPageMenuLinkClick: (event) =>
    element = event.currentTarget
    hash = $(element).attr('href').replace('/', '')
    @scrollToElement(hash)
    return false

  # Helpers

  scrollToElement: (selector, duration) =>
    offset = $('main').offset().top - 1
    duration = duration or 500
    $('html, body').animate({
      scrollTop: $(selector).offset().top - offset
    }, duration)

