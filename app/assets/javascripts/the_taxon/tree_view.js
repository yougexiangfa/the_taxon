function collapse(el){
  var par = $(el).parent().parent()
  var selector = 'tr[data-depth$="' + par.data('depth') + '"]'
  par.nextUntil(selector).hide()
  $(el).replaceWith('<a onclick="expand(this)" href="javascript:void(0)"><i class="grey caret right icon"></i></a>')
}

function expand(el){
  var par = $(el).parent().parent()
  var selector = 'tr[data-depth$="' + par.data('depth') + '"]'
  par.nextUntil(selector).show()
  $(el).replaceWith('<a onclick="collapse(this)" href="javascript:void(0)"><i class="grey caret down icon"></i></a>')
}