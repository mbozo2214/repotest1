class CreateJoyas < ActiveRecord::Migration[7.0]
  def change
    create_table :joyas do |t|
      t.integer :cantidad
      t.string :estado
      t.datetime :fecha_compra
      t.references :publicacion, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
