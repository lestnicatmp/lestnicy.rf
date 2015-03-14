    options = $('.filter.turn .option')
    options.click ->
      $(this).toggleClass('active')
      if options.length == options.filter('.active').length
        options.removeClass('active')
      applyTurnFilter()
      return false

    applyTurnFilter = ->
      $('.stairs').hide()
      # Get allowed values
      allowed = []
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

