class CategoryModule

  # General

  run: =>
    $('.category-item-link').click(@on_item_click)

  # Bindings

  on_item_click: (event) =>
    event.preventDefault()
    element = $(event.currentTarget)
    target = element.parents('.category')
    target.find('.category-heading, .category-image, .category-table').fadeOut 'fast', =>
      target.find('.category-heading-link').attr('href', element.data('link'))
      target.find('.category-heading-name').html(element.data('name'))
      target.find('.category-image').attr('src', element.data('image'))
      target.find('.category-star').data('stair', element.data('slug'))
      target.find('.category-star').trigger('stair_change')
      target.find('.category-price-value').html(element.data('price'))
      target.find('.category-price-currency').hide()
      if element.data('presence')
        target.find('.category-price-currency').show()
      target.find('.category-turn').html(element.data('turn'))
      target.find('.category-height').html(element.data('height'))
      target.find('.category-window').html(element.data('window'))
      target.find('.category-wood').html(element.data('wood'))
      active = 'category-item--active'
      element.parent().siblings().removeClass(active)
      element.parent().addClass(active)
      target.find('.category-heading, .category-image, .category-table').fadeIn('slow')
