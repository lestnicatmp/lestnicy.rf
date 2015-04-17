class DealersModule

  # General

  layouts: ['dealers']

  run: =>
    @init_map()

  init_map: =>
    ymaps.ready =>
      @create_map()
      @fill_map()

  # Logic

  create_map: =>
    @map = new ymaps.Map('map', {center: [60, 100], zoom: 3})

  fill_map: =>
    {% for shop in site.data.shops %}
    shop = new ymaps.Placemark(
      [{{ shop.latitude }}, {{ shop.longitude }}],
      {iconContent: '{{ forloop.index }}',
      balloonContentHeader: '{{ shop.name }}',
      balloonContentBody: '{{ shop.region }}, {{ shop.address }}',
      balloonContentFooter: '<a href="#дилер-{{ forloop.index }}">подбронее</a>',})
    @map.geoObjects.add(shop)
    {% endfor %}

