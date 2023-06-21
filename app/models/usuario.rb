# frozen_string_literal: true
class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :mensajes, dependent: :destroy
  has_many :chatrooms, through: :mensajes
  has_many :joyas, dependent: :destroy
  has_many :comentarios, through: :publicacions
  validates :nombre, :nombre_usuario, :email, :password, :telefono, presence: true
  # validates :nombre_usuario, :email, uniqueness: { message: "already exists" }
  enum tipo_usuario: { normal: 0, vendedor: 1, admin: 2 }
  def tipo_usuario=(value)
    value = value.to_i if value.present?
    super(value)
  end
  # attribute :admin, :boolean, default: false
  # validates :admin, inclusion: { in: [true, false], message: "must be a boolean value" }
  validates :telefono, 
    numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "must be a non-negative integer" }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
