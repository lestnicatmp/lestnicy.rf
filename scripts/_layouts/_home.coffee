    pageMenu = $("#page-menu");
    menuItems = pageMenu.find("a");
    scrollItems = menuItems.map ->
      item = $($(this).attr("href").replace('/', ''))
      if item.length
        return item

    scrollToElement = (selector, duration) ->
      offset = $('main').offset().top - 1
      duration = duration or 500
      $('html, body').animate({
        scrollTop: $(selector).offset().top - offset
      }, duration)

    hash = $(location).attr('hash')
    if hash
      scrollToElement(hash)

    $('#page-menu a').click ->
      hash = $(this).attr('href').replace('/', '')
      scrollToElement(hash)
      return false

    $(window).scroll ->
      # Get container scroll position
      offset = $('main').offset().top + 100
      fromTop = $(this).scrollTop()+offset
      # Get id of current scroll item
      cur = scrollItems.map ->
        if $(this).offset().top < fromTop
          return this
      # Get the id of the current element
      cur = cur[cur.length-1]
      id = cur and if cur.length then cur[0].id else ''
      # Set/remove active class
      menuItems.parent().removeClass('active')
      menuItems.filter("[href='/#"+id+"']").parent().addClass("active")
