---
# Required front matter
---
jQuery ->

  layout = $('body').data('layout')
  if layout == 'home'
{% include_relative _layouts/_home.coffee %}
  if layout == 'params'
{% include_relative _layouts/_params.coffee %}
  if layout == 'select'
{% include_relative _layouts/_select.coffee %}
