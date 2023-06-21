# frozen_string_literal: true
class Mensaje < ApplicationRecord
  belongs_to :chatroom
  belongs_to :usuario
  validates :body, presence: true
end
