class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.string :motivo, null: false
      t.boolean :soporte, null: false, default: false
      t.string :remitente, null: false
      t.string :creador, null: false
      t.string :estado, null: false
      t.timestamps
    end
  end
end
