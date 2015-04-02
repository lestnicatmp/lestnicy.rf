class SelectModule

  # General

  layouts: ['select']

  run: =>
    @bind()

  bind: =>
    $('#article .solution .options li').click(@on_option_click)

  # Bindings

  on_option_click: (event) =>
    element = $(event.currentTarget)
    target = element.parentsUntil('.solution').parent()
    target.find('h2 .name').html(element.data('name'))
    target.find('img').attr('src', element.data('image'))
    target.find('h2 a').attr('href', element.data('href'))
    target.find('.price .value').html(element.data('price'))
    target.find('.price .currency').hide()
    if element.data('presence')
      target.find('.price .currency').show()
    element.siblings().removeClass('active')
    element.addClass('active')
    return false

