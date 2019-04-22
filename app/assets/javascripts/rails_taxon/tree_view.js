// jQuery: nextUntil
function collapse(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).hide();
  el.classList.replace('fa-caret-down', 'fa-caret-right');
  el.addEventListener('click', function(e){
    expand(e.target)
  })
}

function expand(el){
  var par = el.parentNode.parentNode;
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).show();
  el.classList.replace('fa-caret-right', 'fa-caret-down');
  el.addEventListener('click', function(e){
    collapse(e.target)
  })
}

document.querySelectorAll('i.fas.fa-caret-down.grey.link.icon').forEach(function(el) {
  el.addEventListener('click', function(e){
    collapse(e.target);
  });
});

document.querySelectorAll('i.fas.fa-caret-right.grey.link.icon').forEach(function(el) {
  el.addEventListener('click', function(e){
    expand(e.target);
  });
});
