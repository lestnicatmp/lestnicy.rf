---
# Required front matter
---

{% include_relative _application.coffee %}
{% include_relative _cart.coffee %}
{% include_relative _layouts/_home.coffee %}
{% include_relative _layouts/_select.coffee %}
{% include_relative _layouts/_params.coffee %}

jQuery =>
  app = new Application()
  app.register(new CartModule())
  app.register(new HomeModule())
  app.register(new SelectModule())
  app.register(new ParamsModule())
  app.run()

