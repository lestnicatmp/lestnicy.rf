class ParamsModule

  # General

  layouts: ['params']

  run: =>
    @collect()
    @bind()

  collect: =>
    @dom_turns = $('.filter.turn .option')
    @dom_height = $('.filter.height .value')
    @dome_length = $('.filter.window .value.length')
    @dom_width = $('.filter.window .value.width')
    @dom_woods = $('.filter.wood .option')

  bind: =>
    @dom_turns.click(@on_turn_click)
    @dom_height.change(@on_height_change)
    @dome_length.change(@on_length_change)
    @dom_width.change(@on_width_change)
    @dom_woods.click(@on_wood_click)

  update: =>
    @stairs = []
    $('.stair').each (index, value) =>
      element = $(value)
      include = true
      # Turn
      if @turns
        value = element.data('turn')
        value = value.split(/[- ]/)
        if not _.intersection(value, @turns).length
          include = false
      # Height
      if @heigth
        value = element.data('height_min')
        value = @parse(value)
        if @height < value
          include = false
      # Length
      if @length
        value = element.data('window_min')
        value = value.split(/[xх]/)[0]
        value = @parse(value)
        if @length < value['length']
          include = false
      # Width
      if @width
        value = element.data('window_min')
        value = value.split(/[xх]/)[1]
        value = @parse(value)
        if @width < value['width']
          include = false
      # Wood
      if @woods
        value = element.data('wood')
        value = value.split(/[- ]/)
        if not _.intersection(value, @woods).length
          include = false
      if include
        slug = element.data('slug')
        @stairs.push(slug)

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

  parse: (value) =>
    return parseFloat(value.replace(/,/g, '.'))

  # Bindings

  on_turn_click: (event) =>
    element = $(event.currentTarget)
    element.toggleClass('active')
    if @dom_turns.length == @dom_turns.filter('.active').length
      @dom_turns.removeClass('active')
    @turns = []
    force = not @dom_turns.filter('.active').length
    @dom_turns.each (index, value) =>
      element = $(value)
      if force or element.hasClass('active')
        @turns.push(element.val())
    @update()
    @redraw()
    return false

  on_height_change: (event) =>
    @height = @parse(@dom_height.val())
    @update()
    @redraw()

  on_length_change: (event) =>
    @length = @parse(@dome_length.val())
    @update()
    @redraw()

  on_width_change: (event) =>
    @width = @parse(@dom_width.val())
    @update()
    @redraw()

  on_wood_click: (event) =>
    element = $(event.currentTarget)
    element.toggleClass('active')
    if @dom_woods.length == @dom_woods.filter('.active').length
      @dom_woods.removeClass('active')
    @woods = []
    force = not @dom_woods.filter('.active').length
    @dom_woods.each (index, value) =>
      element = $(value)
      if force or element.hasClass('active')
        @woods.push(element.val())
    @update()
    @redraw()
    return false
