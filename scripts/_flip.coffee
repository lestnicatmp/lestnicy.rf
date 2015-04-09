class FlipModule

  # General

  run: =>
    @bind()

  bind: =>
    $('a.flip-left').unbind().click(@on_flip_left_click)
    $('a.flip-right').unbind().click(@on_flip_right_click)

  # Bindings

  on_flip_left_click: (event) =>
    element = $(event.currentTarget)
    element.removeClass('flip-left').addClass('flip-right')
    element.html('правозаходные')
    target = $('.flipped-right')
    target.fadeOut 'fast', =>
      target.removeClass('flipped-right').addClass('flipped-left')
      target.fadeIn('slow')
      @bind()

  on_flip_right_click: (event) =>
    element = $(event.currentTarget)
    element.removeClass('flip-right').addClass('flip-left')
    element.html('левозаходные')
    target = $('.flipped-left')
    target.fadeOut 'fast', =>
      target.removeClass('flipped-left').addClass('flipped-right')
      target.fadeIn('slow')
      @bind()

