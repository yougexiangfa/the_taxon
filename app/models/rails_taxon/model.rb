module RailsTaxon::Model

  def self_and_siblings
    if self.class.column_names.include?('organ_id')
      super.where(organ_id: self.organ_id)
    else
      super
    end
  end

  def depth
    if parent
      parent.depth + 1
    else
      super
    end
  end

end
