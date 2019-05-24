class CreateBaseTable < ActiveRecord::Migration[5.2]

  def change
    create_table :bases do |t|
      t.integer :type
      t.integer :other_id
      t.string :name
    end
  end

end
