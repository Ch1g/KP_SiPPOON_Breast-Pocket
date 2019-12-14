class AlterCrms < ActiveRecord::Migration[6.0]
  def change
    remove_column :crms, :surname
    remove_column :crms, :patronymic
  end
end
