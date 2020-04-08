document.querySelectorAll('select[data-title="parent_ancestors"]').forEach(function(el) {
  el.addEventListener('change', function() {
    if (this.value) {
      let search_url = new URL(location.origin + '/nodes/children')
      search_url.searchParams.set('node_id', this.value)
      search_url.searchParams.set('node_type', this.dataset['type'])
      search_url.searchParams.set('method', this.dataset['method'])
      search_url.searchParams.set('html_id', this.parentNode.parentNode.id)
      if (this.dataset['index']) {
        search_url.searchParams.set('index', this.dataset['index'])
      }
      Rails.ajax({url: search_url, type: 'get', dataType: 'script'})
    } else {
      el = this.parentNode.parentNode.nextElementSibling
      while (el && el.dataset.title === 'parent_ancestors_input') {
        el.remove()
        el = node.nextElementSibling
      }
    }
  })
})
