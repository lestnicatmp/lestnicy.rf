class SelectModule

  # General

  layouts: ['select']

  run: =>
    @bind()

  bind: =>
    $('#article .solution .options a').click(@on_option_click)

  # Bindings

  on_option_click: (event) =>
    element = $(event.currentTarget)
    target = element.parentsUntil('.solution').parent()
    target.children().fadeOut 'fast', =>
      target.find('h2 .name').html(element.data('name'))
      target.find('img').attr('src', element.data('image'))
      target.find('h2 a').attr('href', element.data('href'))
      target.find('.star').data('stair', element.data('slug'))
      target.find('.star').trigger('stair_change')
      target.find('.price .value').html(element.data('price'))
      target.find('.price .currency').hide()
      if element.data('presence')
        target.find('.price .currency').show()
      target.find('.turn').html(element.data('turn'))
      target.find('.window').html(element.data('window'))
      target.find('.height').html(element.data('height'))
      target.find('.wood').html(element.data('wood'))
      element.parentsUntil('table').find('th').removeClass('active')
      element.parent().addClass('active')
      target.children().fadeIn('slow')
    return false

