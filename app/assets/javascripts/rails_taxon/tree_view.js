function collapse(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).hide();
  el.classList.replace('down', 'right')
  el.addEventListener('click', function(e){
    expand(e.target)
  })
}

function expand(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).show();
  el.classList.replace('right', 'down')
  el.addEventListener('click', function(e){
    collapse(e.target)
  })
}

document.querySelectorAll('i.grey.caret.down.icon.link').forEach(function(el) {
  el.addEventListener('click', function(e){
    collapse(e.target);
  });
})

document.querySelectorAll('i.grey.caret.right.icon.link').forEach(function(el) {
  el.addEventListener('click', function(e){
    expand(e.target);
  });
})
