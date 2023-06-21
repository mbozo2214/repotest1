# frozen_string_literal: true
class Publicacion < ApplicationRecord
  has_many :joyas, dependent: :destroy
  has_many :usuarios, through: :comentarios
  has_many :comentarios, dependent: :destroy
  validates :vendedor, :nombre, :tipo_joya, :precio, :descripcion, :color, presence: true
  validates :precio, numericality: { only_integer: true, message: "is not an integer" }
  validates :precio, 
    numericality: {only_integer: true, greater_than_or_equal_to: 0, message: "must be a non-negative integer"}
  mount_uploader :imagen, ImageUploader
end
