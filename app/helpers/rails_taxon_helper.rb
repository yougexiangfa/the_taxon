module RailsTaxonHelper

  def draw_tree(node, partial:)
    str = ''
    node.children.each do |child|
      concat(render partial: partial, locals: { node: child })

      if child.children.any?
        draw_tree(child, partial: partial)
      end
    end
    str
  end

end
