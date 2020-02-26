// jQuery: nextUntil
HTMLElement.prototype.collapse = function() {
  var par = this.parentNode.parentNode
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).hide()
  this.classList.replace('fa-caret-down', 'fa-caret-right');
  this.addEventListener('click', function(e) {
    e.target.expand()
  })
}

HTMLElement.prototype.expand = function() {
  var par = this.parentNode.parentNode
  var selector = 'tr[data-depth$="' + par.dataset['depth'] + '"]';
  $(par).nextUntil(selector).show();
  this.classList.replace('fa-caret-right', 'fa-caret-down');
  this.addEventListener('click', function(e){
    e.target.collapse()
  })
}

document.querySelectorAll('i.fas.fa-caret-down.grey.link.icon').forEach(function(el) {
  el.addEventListener('click', function(e){
    e.target.collapse()
  })
})

document.querySelectorAll('i.fas.fa-caret-right.grey.link.icon').forEach(function(el) {
  el.addEventListener('click', function(e){
    e.target.expand()
  })
})
