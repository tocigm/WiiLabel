$(document).ready ->
  $("#category_select").on 'change', ->
    window.location.search= "?category="+$(this).val()

  category = window.location.href.match(/[?&]category=(.*?)(&|$)/)[1]
  if category != null
    $("#category_select").val(category)