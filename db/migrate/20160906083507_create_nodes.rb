class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :description
      t.integer :node_type
      t.timestamps
    end

    create_table :node_parents do |t|
      t.references :node
      t.references :parent
      t.timestamps
    end
  end
end
