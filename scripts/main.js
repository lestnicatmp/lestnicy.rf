$(document).ready(function () {
    
  var hash = $(location).attr('hash')
  if (hash) {
    scrollToElement(hash);
  }
 
  $('#page-menu a').click(function () {
    var hash = $(this).attr('href').replace('/', '')
    scrollToElement(hash);
    return false;
  });
  
  function scrollToElement(selector, duration) {
    var offset = $('main').offset().top - 1
    var duration = duration || 500;
    $('html, body').animate({
        scrollTop: $(selector).offset().top - offset
    }, duration);
  }
  
  if ($(location).attr('pathname') == '/') {
    var pageMenu = $("#page-menu");
    var menuItems = pageMenu.find("a");
    var scrollItems = menuItems.map(function () {
      var item = $($(this).attr("href").replace('/', ''));
      if (item.length) { return item; }
    });
      
    $(window).scroll(function () {
      // Get container scroll position
      var offset = $('main').offset().top + 100
      var fromTop = $(this).scrollTop()+offset;
    
      // Get id of current scroll item
      var cur = scrollItems.map(function (){
        if ($(this).offset().top < fromTop) {
          return this;
        }
      });
      // Get the id of the current element
      cur = cur[cur.length-1];
      var id = cur && cur.length ? cur[0].id : "";
      // Set/remove active class
      menuItems.parent().removeClass("active");
      menuItems.filter("[href='/#"+id+"']").parent().addClass("active");
    });
  }
  
  $('main .solution .options li').click(function () {
    var self = $(this);
    var target = self.parentsUntil('.solution').parent();
    target.find('h3 .name').html(self.data('name'));
    target.find('img').attr('src', self.data('image'));
    target.find('h3 a').attr('href', self.data('href'));
    target.find('.price .value').html(self.data('price'));
    self.siblings().removeClass("active");
    self.addClass("active");
    return false;
  })
 
  $('#turn-slider').slider({
    range: true,
    min: 0,
    max: 270,
    step: 90,
    values: [0, 270],
    slide: function(event, ui) {
      $('#turn-slider-value').val(ui.values[0]+' - '+ui.values[1]);
    }
  });
  
  $('#height-slider').slider({
    orientation: 'vertical',
    range: true,
    min: 2.5,
    max: 3.5,
    step: 0.1,
    values: [2.5, 3.5],
  });  
});
