    #
    # Bindings
    #

    # Turn
    turn_options = $(".filter.turn .option")
    turn_options.click ->
      $(this).toggleClass("active")
      if turn_options.length == turn_options.filter(".active").length
        turn_options.removeClass("active")
      applyOptionFilter('turn')
      return false

    # Wood
    wood_options = $(".filter.wood .option")
    wood_options.click ->
      $(this).toggleClass("active")
      if wood_options.length == wood_options.filter(".active").length
        wood_options.removeClass("active")
      applyOptionFilter('wood')
      return false

    # Height
    height_range = $(".filter.height .range")
    height_range.change ->
      min = height_range.filter('.min').val()
      max = height_range.filter('.max').val()
      applyHeightFilter(min, max)

    #
    # Functions
    #

    # Count
    updateFilterCounter = ->
      count = $(".stair:visible").length
      $(".message .count").html(count)

    # Options
    applyOptionFilter = (option) ->
      $(".stairs").hide()
      # Get allowed values
      allowed = []
      $(".filter.#{ option } .option").each ->
        if $(this).hasClass("active")
          allowed.push($(this).attr("value"))
      # Show/hide elements
      $(".stair").show()
      if allowed.length
        $(".stair").each ->
          value = $(this).find(".#{ option }").html()
          if $.inArray(value, allowed) != -1
            $(this).show()
          else
            $(this).hide()
      $(".stairs").fadeIn("slow", ->
        updateFilterCounter())

    # Height
    applyHeightFilter = (min, max) ->
      $(".stairs").hide()
      # Show/hide elements
      $(".stair").show()
      $(".stair").each ->
        value = $(this).find('.height').html()
        [value_min, value_max] = value.split('-')
        if not value_max
          value_max = value_min
        value_min = parseFloat(value_min.replace(',', '.'))
        value_max = parseFloat(value_max.replace(',', '.'))
        if value_max >= min and value_min <= max
          $(this).show()
        else
          $(this).hide()
      $(".stairs").fadeIn("slow", ->
        updateFilterCounter())

