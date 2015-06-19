class CartModule

  # General

  run: =>
    @stars = $('[data-star]')
    @stars.click(@on_star_click)
    @stars.bind('product_change', @on_product_change)
    @update()

  update: =>
    @update_menu()
    @update_stars()
    @update_cart()

  # Updaters

  update_menu: =>
    products = @get_products()
    target = $('.header-mainnav-stars')
    target.hide()
    target.html()
    if products.length
      target.find('.header-mainnav-stars-count').html(products.length)
      target.show()

  update_stars: =>
    @stars.map (index, element) =>
      element = $(element)
      product = element.data('star')
      products = @get_products()
      if product in products
        element.removeClass('uk-icon-star-o').addClass('uk-icon-star')
      else
        element.removeClass('uk-icon-star').addClass('uk-icon-star-o')

  update_cart: =>
    products = @get_products()
    elements = $('body[data-route="select/catalog/cart"] .product')
    elements.map (index, element) =>
      element = $(element)
      product = element.find('[data-star]').data('star')
      element.hide()
      if product in products
        element.show()
    elements.filter(':visible:first').css('border-top', 'none')

  # Bindings

  on_star_click: (event) =>
    element = $(event.currentTarget)
    product = element.data('star')
    products = @get_products()
    if product in products
      products = _.without(products, product)
    else
      products.push(product)
    @set_products(products)
    @update()

  on_product_change: (event) =>
    @update()

  # Storage

  get_products: =>
    products = []
    if localStorage.cart
      products = JSON.parse(localStorage.cart)
    return products

  set_products: (products) =>
    localStorage.cart = JSON.stringify(products)
