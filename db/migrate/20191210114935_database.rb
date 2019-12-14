class Database < ActiveRecord::Migration[6.0]
  def change
    create_table :crms, primary_key: :id_crm do |t|
      t.string :name, limit: 30
      t.string :surname, limit: 30
      t.string :patronymic, limit: 30
      t.string :mail, limit: 100
      t.string :feedback, limit: 150
    end

  end
end
