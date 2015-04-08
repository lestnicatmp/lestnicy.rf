class RememberModule

  # General

  run: =>
    @bind()
    @update()

  bind: =>
    $('.star').click(@on_star_click)
    $('.star').bind('stair_change', @on_star_change_data)

  update: =>
    @update_stars()

  # Updaters

  update_stars: =>
    $('.star').map (index, element) =>
      element = $(element)
      stair = element.data('stair')
      stairs = @get_stairs()
      if stair in stairs
        element.removeClass('fa-star-o').addClass('fa-star')
      else
        element.removeClass('fa-star').addClass('fa-star-o')

  # Bindings

  on_star_click: (event) =>
    element = $(event.currentTarget)
    stair = element.data('stair')
    stairs = @get_stairs()
    if stair in stairs
      stairs = _.without(stairs, stair)
    else
      stairs.push(stair)
    @set_stairs(stairs)
    @update()

  on_star_change_data: (event) =>
    @update()

  # Helpers

  get_stairs: =>
    stairs = []
    if localStorage.stairs
      stairs = localStorage.stairs.split(',')
    return stairs

  set_stairs: (stairs) =>
    localStorage.stairs = stairs.join(',')

