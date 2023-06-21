# frozen_string_literal: true
require "test_helper"

class PublicacionTest < ActiveSupport::TestCase

  setup do
    @publicacion = publicacions(:one)
  end

  test "svalidacion_publicacion" do
    assert @publicacion.valid?
  end

  test "test_presencia_nombre" do
    @publicacion.nombre = ""
    result = @publicacion.save
    assert_not result, "saved the publicacion without nombre"
  end

  test "test_presencia_tipo_joya" do
    @publicacion.tipo_joya = ""
    result = @publicacion.save
    assert_not result, "saved the publicacion without tipo  joya"
  end

  test "test_presencia_descripcion" do
    @publicacion.descripcion = ""
    result = @publicacion.save
    assert_not result, "saved the publicacion without descripcion"
  end

  test "precio_sea_positivo" do
    @publicacion.precio = -10
    result = @publicacion.save
    assert_not result,  "must be a non-negative integer"
  end

  test "precio_sea_numero" do
    @publicacion.precio = "ola"
    result = @publicacion.save
    assert_not result, "saved publicaion with string in precio"
  end

end