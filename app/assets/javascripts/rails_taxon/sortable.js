import { Controller } from 'stimulus'
import Sortable from 'sortablejs'

class SortableController extends Controller {
  connect() {
    let self = this.element;
    Sortable.create(self, {
      onEnd: function(evt) {
        if (evt.oldIndex === evt.newIndex) {
          return
        }
        var url = self.dataset['src'] + evt.item.dataset['id'] + '/reorder';
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
application.register('sortable', SortableController);
