    $('main .solution .options li').click ->
      self = $(this)
      target = self.parentsUntil('.solution').parent()
      target.find('h3 .name').html(self.data('name'))
      target.find('img').attr('src', self.data('image'))
      target.find('h3 a').attr('href', self.data('href'))
      target.find('.price .value').html(self.data('price'))
      self.siblings().removeClass('active')
      self.addClass('active')
      return false

