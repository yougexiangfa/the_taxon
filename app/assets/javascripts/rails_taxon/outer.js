$('[data-title="node_ancestors"]').dropdown({
  placeholder: false,
  onChange: function(value, text, $selectedItem){
    var search_path = '/nodes/outer';
    var search_url = new URL(window.location.origin + search_path);
    if (value) {
      search_url.searchParams.set('node_id', value);
      search_url.searchParams.set('node_type', this.dataset['nodeType']);
      search_url.searchParams.set('entity_type', this.dataset['entityType']);
      search_url.searchParams.set('index', this.dataset['index']);
      search_url.searchParams.set('method', this.dataset['method']);

      Rails.ajax({url: search_url, type: 'GET', dataType: 'script'});
    } else {
      $(this).parent().parent().nextAll().remove();
    }
  }
});
