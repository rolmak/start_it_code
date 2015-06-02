#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require cocoon
#= require popcorn-complete
#= require ckeditor/ckeditor
#= require ckeditor/config
#= require education_menu

$ ->
  if $(".video").length > 0
    $(".video").each (index, elem) ->
      $node = $(elem)
      id = "##{$node.attr('id')}"
      url = $node.data("video")
      Popcorn.vimeo id, url
