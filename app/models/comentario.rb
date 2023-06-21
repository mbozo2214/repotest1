# frozen_string_literal: true
class Comentario < ApplicationRecord
  belongs_to :publicacion
  belongs_to :usuario
  validates :contenido, presence: true
  validates :calificacion, numericality: { only_integer: true, message: "is not an integer" }
  validates :calificacion, 
    numericality: {
      only_integer: true, 
      greater_than_or_equal_to: 1, 
      less_than_or_equal_to: 5, 
      message: "must be an integer between 1 and 5",}
end
