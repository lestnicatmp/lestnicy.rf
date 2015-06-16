class FlipModule

  # General

  run: =>
    @links = $('a[data-flip]')
    @images = $('img[data-flip]')
    @links.click(@on_link_click)
    @update()

  update: (click) =>
    flip = @get()
    if click
      animation = 'uk-animation-fade'
      @links.addClass(animation)
      @images.addClass(animation)
      setTimeout(( =>
        @links.removeClass(animation)
        @images.removeClass(animation)
      ), 1000)
    if flip
      @links.html('левозаходные')
      @images.addClass('ut-flip')
    else
      @links.html('правозаходные')
      @images.removeClass('ut-flip')

  # Bindings

  on_link_click: (event) =>
    event.preventDefault()
    @set(not @get())
    @update(true)

  # Storage

  get: =>
    return JSON.parse(localStorage.flip || 'false')

  set: (flip) =>
    localStorage.flip = JSON.stringify(flip)
