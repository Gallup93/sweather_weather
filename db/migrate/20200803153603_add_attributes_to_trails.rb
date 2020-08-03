class AddAttributesToTrails < ActiveRecord::Migration[5.2]
  def change
    add_column :trails, :attributes, :text
  end
end
