# frozen_string_literal: true
require "test_helper"

class ComentarioTest < ActiveSupport::TestCase

  setup do
    @comentario1 = comentarios(:comentario1)
    @comentario2 = comentarios(:comentario2)
    @comentario3 = comentarios(:comentario3)
  end

  # Testeo de validacion
  test "test_validaciones" do
    result = @comentario1.valid?
    assert result
  end

  # Testeo de comentario sin contenido
  test "test_crear_comentario_con_contenido" do
    @comentario1.contenido = ""
    result = @comentario1.save
    assert_not result, "post without content"
  end

  # Testeo de valoracion numero entero
  test "test_calificacion_entera" do
    @comentario2.calificacion = 4.5
    refute @comentario2.valid?
    assert_includes @comentario2.errors[:calificacion], "is not an integer"
  end

  # Testeo de valoracion entre numeros 1 y 5
  test "test_calificacion_entre_1_y_5" do
    @comentario3.calificacion = 10
    refute @comentario3.valid?
    assert_includes @comentario3.errors[:calificacion], "must be an integer between 1 and 5"
  end

  # Testeo de instancias correctas
  test "test_pertenece_a_publicacion_y_usuario" do
    assert_instance_of Publicacion, @comentario1.publicacion
    assert_instance_of Usuario, @comentario1.usuario
  end
end
