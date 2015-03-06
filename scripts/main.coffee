jQuery ->


  if $('body').data('layout') == 'home'

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


  if $('body').data('layout') == 'select'

    $('main .solution .options li').click ->
      self = $(this)
      target = self.parentsUntil('.solution').parent()
      target.find('h3 .name').html(self.data('name'))
      target.find('img').attr('src', self.data('image'))
      target.find('h3 a').attr('href', self.data('href'))
      target.find('.price .value').html(self.data('price'))
      self.siblings().removeClass('active')
      self.addClass('active')
      return false


  if $('body').data('layout') == 'params'

    options = $('.filter.turn .option')
    options.click ->
      $(this).toggleClass('active')
      if options.length == options.filter('.active').length
        options.removeClass('active');
      applyTurnFilter()
      return false

    applyTurnFilter = ->
      $('.stairs').hide();
      # Get allowed values
      allowed = [];
      $('.filter.turn .option').each ->
        if $(this).hasClass('active')
          allowed.push($(this).attr('value'))
      # Show/hide elements
      $('.stair').show()
      if allowed.length
        $('.stair').each ->
          value = $(this).find('.turn').html()
          if ($.inArray(value, allowed) != -1)
            $(this).show()
          else
            $(this).hide()
      $('.stairs').fadeIn('slow', ->
        updateFilterCounter())

    updateFilterCounter = ->
      count = $('.stair:visible').length
      $('.message .count').html(count)
