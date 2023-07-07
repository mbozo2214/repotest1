class CreatePublicacions < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacions do |t|
      t.string :codigo
      t.string :nombre
      t.string :categoria
      t.integer :precio
      t.text :descripcion
      t.string :unidad
      t.integer :stock
      t.string :imagen

      t.timestamps
    end
  end
end
