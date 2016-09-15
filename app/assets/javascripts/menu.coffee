$(document).ready ->

#  $(window).on 'hashchange', ->
#    category = window.location.href.match(/[?&]category=(.*?)(&|$)/)
#    if category != null
#      $("#category_select").val(category[1])

  category = window.location.href.match(/[?&]category=(.*?)(&|$)/)
  if category != null
    $("#category_select").val(category[1])

  $("#category_select").on 'change', ->
#    $(location).attr('search', "?category="+$(this).val())
    window.location.search = "?category="+$(this).val()

