//= require rails_com/fetch_xhr_script

$('[data-title="outer_ancestors"]').dropdown({
  placeholder: false,
  onChange: function(value, text, $selectedItem){
    var search_path = '/nodes/outer';
    var search_url = new URL(window.location.origin + search_path);
    search_url.searchParams.set('node_id', value);
    search_url.searchParams.set('node_type', this.dataset['type'])
    search_url.searchParams.set('outer_type', this.dataset['outer'])

    fetch_xhr_script(search_url);
  }
});