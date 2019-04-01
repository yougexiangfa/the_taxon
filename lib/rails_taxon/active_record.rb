module RailsTaxon::ActiveRecord

  def has_taxons(*columns)
    columns.each do |column|
      attribute "#{column}_ancestors", :integer, array: true
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        before_save :sync_#{column}_id, if: -> { #{column}_ancestors_changed? }
        
        def sync_#{column}_id
          self.#{column}_id = #{column}_ancestors.values.compact.last
        end
      RUBY_EVAL
    end
  end

end

ActiveSupport.on_load :active_record do
  extend RailsTaxon::ActiveRecord
end
