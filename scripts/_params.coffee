class ParamsModule

  # General

  layouts: ['params']

  run: =>
    @collect()
    @update()
    @bind()

  collect: =>
    @dom_turn_options = $('.filter.turn .option')
    @dom_window_range = $('.filter.window .range')
    @dom_height_range = $('.filter.height .range')
    @dom_wood_options = $('.filter.wood .option')

  update: =>
    @update_turn_options()
    @update_height_range()
    @update_window_range()
    @update_wood_options()
    @update_stairs()

  bind: =>
    @dom_turn_options.click(@on_turn_option_click)
    @dom_window_range.change(@on_window_range_change)
    @dom_height_range.change(@on_height_range_change)
    @dom_wood_options.click(@on_wood_option_click)

  redraw: =>
    $('.message').hide()
    $('.stairs').hide()
    $('.stair').each (index, value) =>
      element = $(value)
      element.hide()
      slug = element.data('slug')
      if slug in @stairs
        element.show()
    count = @stairs.length
    $('.message .count').html(count)
    $('.message').fadeIn('fast')
    $('.stairs').fadeIn('fast')

  # Updaters

  update_turn_options: =>
    @turn_options = []
    force = not @dom_turn_options.filter('.active').length
    @dom_turn_options.each (index, value) =>
      element = $(value)
      if force or element.hasClass('active')
        @turn_options.push(element.val())

  update_window_range: =>
    @window_left_min = parseFloat(@dom_window_range.filter('.left_min').val())
    @window_left_max = parseFloat(@dom_window_range.filter('.left_max').val())
    @window_right_min = parseFloat(@dom_window_range.filter('.right_min').val())
    @window_right_max = parseFloat(@dom_window_range.filter('.right_max').val())

  update_height_range: =>
    @height_min = parseFloat(@dom_height_range.filter('.min').val())
    @height_max = parseFloat(@dom_height_range.filter('.max').val())

  update_wood_options: =>
    @wood_options = []
    force = not @dom_wood_options.filter('.active').length
    @dom_wood_options.each (index, value) =>
      element = $(value)
      if force or element.hasClass('active')
        @wood_options.push(element.val())

  update_stairs: =>
    @stairs = []
    $('.stair').each (index, value) =>
      element = $(value)
      include = true
      # Turn
      value = element.find('.turn').html()
      value = @parse_option(value)
      if not _.intersection(value, @turn_options).length
        include = false
      # Window
      value = element.find('.window').html()
      value = @parse_window_value(value)
      if value['left_max'] < @window_left_min or
         value['left_min'] > @window_left_max or
         value['right_max'] < @window_right_min or
         value['right_min'] > @window_right_max
        include = false
      # Height
      value = element.find('.height').html()
      value = @parse_height_value(value)
      if value['max'] < @height_min or
         value['min'] > @height_max
        include = false
      # Wood
      value = element.find('.wood').html()
      value = @parse_option(value)
      if not _.intersection(value, @wood_options).length
        include = false
      if include
        slug = element.data('slug')
        @stairs.push(slug)

  # Bindings

  on_turn_option_click: (event) =>
    element = $(event.currentTarget)
    element.toggleClass('active')
    if @dom_turn_options.length == @dom_turn_options.filter('.active').length
      @dom_turn_options.removeClass('active')
    @update()
    @redraw()
    return false

  on_window_range_change: (event) =>
    @update()
    @redraw()

  on_height_range_change: (event) =>
    @update()
    @redraw()

  on_wood_option_click: (event) =>
    element = $(event.currentTarget)
    element.toggleClass('active')
    if @dom_wood_options.length == @dom_wood_options.filter('.active').length
      @dom_wood_options.removeClass('active')
    @update()
    @redraw()
    return false

  # Parsers

  parse_window_value: (value) =>
    value = value.replace(/,/g, '.')
    [left, right] = value.split(/[xх]/)
    [left_min, left_max] = left.split('-')
    [right_min, right_max] = right.split('-')
    if not left_max
      left_max = left_min
    if not right_max
      right_max = right_min
    result =
      left_min: parseFloat(left_min)
      left_max: parseFloat(left_max)
      right_min: parseFloat(right_min)
      right_max: parseFloat(right_max)
    return result

  parse_height_value: (value) =>
    value = value.replace(/,/g, '.')
    [min, max] = value.split('-')
    if not max
      max = min
    result =
      min: parseFloat(min)
      max: parseFloat(max)
    return result

  parse_option: (value) =>
    return value.split(/[- ]/)

