#= require jquery
#= require jquery_ujs

# Add active class to lesson and in class to level
setNavigation = ->
  path = window.location.pathname
  path = path.replace(/\/$/, '')
  path = decodeURIComponent(path)
  $('.menu a').each ->
    href = $(this).attr('href')
    if path.substring(0, href.length) == href
      $(this).closest('.panel-body a').addClass 'active'
      $(this).closest('.panel-heading .panel-collapse').addClass 'in'

$ ->
  setNavigation()
