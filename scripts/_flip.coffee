class FlipModule

  # General

  run: =>
    @bind()
    @update()

  bind: =>
    $('a.flip-left').unbind().click(@on_flip_left_click)
    $('a.flip-right').unbind().click(@on_flip_right_click)

  update: =>
    @update_flip()

  # Updaters

  update_flip: =>
    flip = @get_flip()
    if flip == 'right'
      $('a.flip-right').click()
    else
      $('a.flip-left').click()

  # Bindings

  on_flip_left_click: (event) =>
    element = $(event.currentTarget)
    element.removeClass('flip-left').addClass('flip-right')
    element.html('левозаходные')
    target = $('.flipped-right')
    target.fadeOut 'fast', =>
      target.removeClass('flipped-right').addClass('flipped-left')
      target.fadeIn('slow')
      @set_flip('left')
      @bind()

  on_flip_right_click: (event) =>
    element = $(event.currentTarget)
    element.removeClass('flip-right').addClass('flip-left')
    element.html('правозаходные')
    target = $('.flipped-left')
    target.fadeOut 'fast', =>
      target.removeClass('flipped-left').addClass('flipped-right')
      target.fadeIn('slow')
      @set_flip('right')
      @bind()

  # Storage

  get_flip: =>
    flip = localStorage.flip
    if not flip
      flip = 'right'
    return flip

  set_flip: (flip) =>
    localStorage.flip = flip

