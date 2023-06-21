# frozen_string_literal: true
require "test_helper"

class UsuarioTest < ActiveSupport::TestCase
  setup do
    @usuario = usuarios(:admin1)
    @usuario1 = usuarios(:user1)
    @usuario2 = usuarios(:user2)
  end

  test "test_validaciones" do
    # Necesario crear password porque con el devise
    @usuario1.password = "password"
    result = @usuario1.valid?
    assert result
  end

  # Testeo de guardado ADMIN sin nombre
  test "test_no_guardar_sin_nombre" do
    @usuario.nombre = ""
    result = @usuario.save
    assert_not result, "saved the usuario without a name"
  end

  # Testeo de guardado USER sin email
  test "test_no_guardar_sin_email" do
    @usuario1.email = ""
    result = @usuario1.save
    assert_not result, "saved the usuario without an email"
  end

  # Testeo de guardado USER ya existente
  test "test_no_guardar_usuario_ya_existente" do
    @usuario2.nombre_usuario = @usuario1.nombre_usuario
    result = @usuario2.save
    assert_not result, "saved the usuario that already exists"
    assert_equal ["already exists"], @usuario2.errors[:nombre_usuario]
  end

  # Testeo de guardado EMAIL ya existente
  test "test_no_guardar_email_ya_existente" do
    @usuario2.email = @usuario1.email
    result = @usuario2.save
    assert_not result, "saved the usuario with an email that already exists"
  end

  # Testeo de guardado USER con teléfono negativo
  test "test_no_guardar_telefono_negativo" do
    @usuario1.telefono = -123
    result = @usuario1.save
    assert_not result, "saved the usuario with a negative phone number"
    assert_equal ["must be a non-negative integer"], @usuario1.errors[:telefono]
  end
end
