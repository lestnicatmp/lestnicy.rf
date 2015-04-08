---
# Required front matter
---

{% include_relative _application.coffee %}
{% include_relative _remember.coffee %}
{% include_relative _layouts/_home.coffee %}
{% include_relative _layouts/_select.coffee %}
{% include_relative _layouts/_params.coffee %}

jQuery =>
  app = new Application()
  app.register(new RememberModule())
  app.register(new HomeModule())
  app.register(new SelectModule())
  app.register(new ParamsModule())
  app.run()

