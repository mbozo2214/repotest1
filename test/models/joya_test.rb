# frozen_string_literal: true
require "test_helper"

class JoyaTest < ActiveSupport::TestCase

  setup do
    @joya_one = joyas(:one)
    @joya_two = joyas(:two)
  end

  test "validacion_joya" do
    assert @joya_one.valid?
  end

  test "test_precencia_cantidad" do
    @joya_one.cantidad = ""
    result = @joya_one.save
    assert_not result, "saved the joya without cantidad"
  end

  test "test_cantidad_sea_positivo" do
    @joya_one.cantidad = -1
    result = @joya_one.save
    assert_not result, "saved the joya with negative integer"
  end

  test "test_cantidad_sea_numero" do
    @joya_two.cantidad = "string"
    result = @joya_two.save
    assert_not result, "saved the joya with string in cantidad"
  end

  test "test_asociaciones" do
    assert_respond_to @joya_one, :publicacion
    assert_respond_to @joya_one, :usuario
  end
end
