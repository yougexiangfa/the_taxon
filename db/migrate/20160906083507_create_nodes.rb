class CreateNodes < ActiveRecord::Migration[5.0]
  def change

    create_table :nodes do |t|
      t.string :name
      t.string :description
      t.integer :parent_id
      t.string :parent_ids
      t.string :child_ids
      t.timestamps
    end

  end
end
