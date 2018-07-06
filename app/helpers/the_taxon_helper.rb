module TheTaxonHelper

  def draw_tree(node, partial:)
    str = ''
    node.children.each do |child|
      concat(render partial: partial, locals: {child: child})

      if child.children.any?
        draw_tree(child, partial: partial)
      end
    end
    str
  end

end
