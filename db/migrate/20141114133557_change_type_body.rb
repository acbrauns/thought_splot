class ChangeTypeBody < ActiveRecord::Migration
  def change
    change_column :journals, :body, :text
  end
end
