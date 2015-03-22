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

    #
    # Functions
    #

    # Count
    updateFilterCounter = ->
      count = $(".stair:visible").length
      $(".message .count").html(count)

    # Options
    applyOptionFilter = (option) ->
      console.log(option)
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
          if ($.inArray(value, allowed) != -1)
            $(this).show()
          else
            $(this).hide()
      $(".stairs").fadeIn("slow", ->
        updateFilterCounter())

