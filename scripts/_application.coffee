class Application

  # Public

  constructor: ->
    @modules = []

  run: =>
    layout = $('body').data('layout')
    section = $('body').data('section')
    page = $('body').data('page')
    for module in @modules
      if module.layouts
        if layout in module.layouts
          module.run()
      else if module.sections
        if section in module.sections
          module.run()
      else if module.pages
        if page in module.pages
          module.run()
      else
        module.run()

  register: (module) =>
    @modules.push(module)

