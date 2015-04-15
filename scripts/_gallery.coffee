class GalleryModule

  # General

  run: =>
    @bind()

  bind: =>
    $('.zoomable').click(@on_zoomable_click)

  # Bindings

  on_zoomable_click: (event) =>
    element = $(event.currentTarget)
    container = $('.pswp').get(0)
    uiclass = PhotoSwipeUI_Default
    images = []
    for item in [element].concat(element.siblings('img').toArray())
      item=$(item)
      image =
        src: item.data('source')
        w: item.data('source-width')
        h: item.data('source-height')
        title: item.data('source-title')
      images.push(image)
    options =
      index: 0
      shareEl: false
      bgOpacity: 1
    gallery = new PhotoSwipe(container, uiclass, images, options)
    gallery.init()
