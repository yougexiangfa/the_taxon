function collapse(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.data('depth') + '"]';
  par.nextUntil(selector).hide();
  $(el).replaceWith('<i class="grey caret right icon link"></i>')
}

function expand(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.data('depth') + '"]';
  par.nextUntil(selector).show();
  $(el).replaceWith('<i class="grey caret down icon link"></i>')
}

document.querySelectorAll('.grey.caret.down.icon.link').addEventListener('click', function(e){
  collapse(e.target);
});

document.querySelectorAll('.grey.caret.right.icon.link').addEventListener('click', function(e){
  expand(e.target);
});
