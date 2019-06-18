module RailsTaxon::TreeHelper

  # first locals must be node
  def draw_tree(partial: , object: , **options)
    str = ''
    
    object.children.each do |child|
      concat(render partial: partial, object: child, **options)

      if child.children.any?
        draw_tree(partial: partial, object: child, **options)
      end
    end
   
    str
  end

end
