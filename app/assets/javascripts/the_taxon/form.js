//= require rails_com/fetch_xhr_script

$('[data-title="parent_ancestors"]').dropdown({
  placeholder: false,
  onChange: function(value, text, $selectedItem){
    var search_path = '/hr/departments/parents';
    var search_url = new URL(window.location.origin + search_path);
    search_url.searchParams.set('parent_id', value);
    search_url.searchParams.set('previous_id', this.dataset['id']);

    var params = {
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/javascript',
        'X-CSRF-Token': document.head.querySelector("[name=csrf-token]").content
      }
    };
    fetch_xhr_script(search_url, params);
  }
});