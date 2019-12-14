class TableUpd < ActiveRecord::Migration[6.0]
  def change
    remove_column :versions, :changes
    add_column :versions, :version_change, :string, limit: 255
  end
end
