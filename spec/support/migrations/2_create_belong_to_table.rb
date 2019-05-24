class CreateBelongToTable < ActiveRecord::Migration[5.2]

  def change
    create_table :belongs_tos do |t|
      t.integer :base_id
      t.integer :left_child_id
    end
  end

end
