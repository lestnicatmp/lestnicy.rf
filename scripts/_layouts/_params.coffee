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

    # Window
    window_range = $(".filter.window .range")
    window_range.change ->
      left_min = window_range.filter('.left_min').val()
      left_max = window_range.filter('.left_max').val()
      right_min = window_range.filter('.right_min').val()
      right_max = window_range.filter('.right_max').val()
      applyWindowFilter(left_min, left_max, right_min, right_max)

    # Height
    height_range = $(".filter.height .range")
    height_range.change ->
      min = height_range.filter('.min').val()
      max = height_range.filter('.max').val()
      applyHeightFilter(min, max)

    # Wood
    wood_options = $(".filter.wood .option")
    wood_options.click ->
      $(this).toggleClass("active")
      if wood_options.length == wood_options.filter(".active").length
        wood_options.removeClass("active")
      applyOptionFilter('wood')
      return false

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
          values = $(this).find(".#{ option }").html()
          values = values.split(/[- ]/)
          if _.intersection(values, allowed).length
            $(this).show()
          else
            $(this).hide()
      $(".stairs").fadeIn("slow", ->
        updateFilterCounter())

    # Window
    applyWindowFilter = (left_min, left_max, right_min, right_max) ->
      $(".stairs").hide()
      # Show/hide elements
      $(".stair").show()
      $(".stair").each ->
        value = $(this).find('.window').html()
        value = value.replace(/,/g, '.')
        [value_left, value_right] = value.split(/[xх]/)
        console.log(value_left, value_right)
        [value_left_min, value_left_max] = value_left.split('-')
        [value_right_min, value_right_max] = value_right.split('-')
        if not value_left_max
          value_left_max = value_left_min
        if not value_right_max
          value_right_max = value_right_min
        value_left_min = parseFloat(value_left_min)
        value_left_max = parseFloat(value_left_max)
        value_right_min = parseFloat(value_right_min)
        value_right_max = parseFloat(value_right_max)
        if value_left_max >= left_min and value_left_min <= left_max and
           value_right_max >= right_min and value_right_min <= right_max
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
        value = value.replace(/,/g, '.')
        [value_min, value_max] = value.split('-')
        if not value_max
          value_max = value_min
        value_min = parseFloat(value_min)
        value_max = parseFloat(value_max)
        if value_max >= min and value_min <= max
          $(this).show()
        else
          $(this).hide()
      $(".stairs").fadeIn("slow", ->
        updateFilterCounter())

