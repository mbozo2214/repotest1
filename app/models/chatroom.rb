# frozen_string_literal: true
class Chatroom < ApplicationRecord
  has_many :usuarios, through: :mensajes
  has_many :mensajes, dependent: :destroy
  validates :motivo, :remitente, :creador, :estado, presence: true
  validates :soporte, inclusion: { in: [true, false] }
end
