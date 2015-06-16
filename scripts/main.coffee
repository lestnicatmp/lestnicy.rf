jQuery =>
  app = new Application()
  app.register(new CartModule())
  app.register(new CategoryModule())
  app.register(new FlipModule())
  app.register(new HeroModule())
  app.register(new ScrollModule())
  app.run()
