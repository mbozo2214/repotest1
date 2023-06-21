class CreatePublicacions < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacions do |t|
      t.string :vendedor
      t.string :nombre
      t.string :tipo_joya
      t.integer :precio
      t.text :descripcion
      t.string :color
      t.string :imagen

      t.timestamps
    end
  end
end
