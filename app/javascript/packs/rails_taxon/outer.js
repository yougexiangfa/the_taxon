document.querySelectorAll('select[data-title="outer_ancestors"]').forEach(function(el) {
  el.addEventListener('change', function() {
    let search_url = new URL(location.origin + '/nodes/outer')
    if (this.value) {
      search_url.searchParams.set('node_id', this.value)
      search_url.searchParams.set('node_type', this.dataset['nodeType'])
      search_url.searchParams.set('as', this.dataset['as'])
      search_url.searchParams.set('method', this.dataset['method'])
      search_url.searchParams.set('outer', this.dataset['outer'])
      search_url.searchParams.set('html_id', this.parentNode.parentNode.id)
      if (this.dataset['index']) {
        search_url.searchParams.set('index', this.dataset['index'])
      }

      Rails.ajax({url: search_url, type: 'GET', dataType: 'script'})
    } else {
      el = this.parentNode.parentNode.nextElementSibling
      while (el && el.dataset.title === 'outer_ancestors_input') {
        el.remove()
        el = node.nextElementSibling
      }
    }
  })
})
