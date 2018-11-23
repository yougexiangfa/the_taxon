$('[data-title="parent_ancestors"]').dropdown({
  placeholder: false,
  onChange: function(value, text, $selectedItem){
    if (value) {
      var search_path = '/nodes/children';
      var search_url = new URL(window.location.origin + search_path);
      search_url.searchParams.set('node_id', value);
      search_url.searchParams.set('node_type', this.dataset['type']);

      Rails.ajax({url: search_url, type: 'get', dataType: 'script'});
    }
  }
});
