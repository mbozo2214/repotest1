# frozen_string_literal: true
class Joya < ApplicationRecord
  belongs_to :publicacion
  belongs_to :usuario
  validates :cantidad, :estado, presence: true
  validates :cantidad, numericality: {only_integer: true, message: "is not an integer" }
  validates :cantidad, 
    numericality: {only_integer: true, greater_than_or_equal_to: 0, message: "must be a non-negative integer"}
end
