class AddTables < ActiveRecord::Migration[6.0]
  def change
    create_table :users, primary_key: :id_user do |t|
      t.string :login
      t.string :password
    end

    create_table :versions, primary_key: :id_version do |t|
      t.string :version, limit: 10
      t.string :changes, limit: 255
    end
  end
end
