class CartModule

  # General

  run: =>
    @bind()
    @update()

  bind: =>
    $('.star').click(@on_star_click)
    $('.star').bind('stair_change', @on_star_change_data)

  update: =>
    @update_menu()
    @update_stars()
    @update_stairs()

  # Updaters

  update_menu: =>
    stairs = @get_stairs()
    target = $('#site-menu .stars')
    target.hide()
    target.html()
    if stairs.length
      target.find('.count').html(stairs.length)
      target.show()

  update_stars: =>
    $('.star').map (index, element) =>
      element = $(element)
      stair = element.data('stair')
      stairs = @get_stairs()
      if stair in stairs
        element.removeClass('fa-star-o').addClass('fa-star')
      else
        element.removeClass('fa-star').addClass('fa-star-o')

  update_stairs: =>
    stairs = @get_stairs()
    elements = $('body[data-layout="cart"] .stair')
    elements.map (index, element) =>
      element = $(element)
      stair = element.find('.star').data('stair')
      element.hide()
      if stair in stairs
        element.show()
    elements.filter(':visible:first').css('border-top', 'none')
    elements.filter(':visible:last').css('border-bottom', 'none')

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

  # Storage

  get_stairs: =>
    stairs = []
    if localStorage.cart
      stairs = localStorage.cart.split(',')
    return stairs

  set_stairs: (stairs) =>
    localStorage.cart = stairs.join(',')
