class CreateMensajes < ActiveRecord::Migration[7.0]
  def change
    create_table :mensajes do |t|
      t.string :body, null: false
      t.references :usuario, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true
      t.timestamps
    end
  end
end
