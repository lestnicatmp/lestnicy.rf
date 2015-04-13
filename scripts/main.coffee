---
# Required front matter
---

{% include_relative _application.coffee %}
{% include_relative _cart.coffee %}
{% include_relative _flip.coffee %}
{% include_relative _home.coffee %}
{% include_relative _select.coffee %}
{% include_relative _params.coffee %}
{% include_relative _shops.coffee %}

jQuery =>
  app = new Application()
  app.register(new CartModule())
  app.register(new FlipModule())
  app.register(new HomeModule())
  app.register(new SelectModule())
  app.register(new ParamsModule())
  app.register(new ShopsModule())
  app.run()

