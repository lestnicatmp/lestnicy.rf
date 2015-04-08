class Application

  # Public

  constructor: ->
    @modules = []

  run: =>
    layout = $('body').data('layout')
    for module in @modules
      if module.layouts
        if layout in module.layouts
          module.run()
      else
        module.run()

  register: (module) =>
    @modules.push(module)

