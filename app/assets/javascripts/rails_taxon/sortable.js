//= require sortablejs

class SortableController extends Stimulus.Controller {
  connect() {
    var el = document.getElementById('task_lists');
    var sortable = Sortable.create(el, {
      onEnd: function(evt) {
        if (evt.oldIndex === evt.newIndex) {
          return
        }
        var url = '/my/tasks/' + evt.item.getAttribute('data-id') + '/reorder';
        var body = new FormData();
        this.toArray().forEach(function(el){
          body.append('sort_array[]', el);
        });
        body.append('old_index', evt.oldIndex);
        body.append('new_index', evt.newIndex);

        Rails.ajax({url: url, type: 'PATCH', dataType: 'script', data: body})
      }
    });
  }
}
SortableController.targets = ['src'];
application.register('sortable', SortableController);
