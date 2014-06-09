class CreateBaseTable < ActiveRecord::Migration

  def change
    create_table :bases do |t|
      t.integer :type
      t.string :name
    end
  end

end
