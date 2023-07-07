# frozen_string_literal: true
require "prawn"
class CarritoController < ApplicationController
  before_action :set_publicacion, only: [:create, :destroy]
  def index
    unless current_usuario
      redirect_to(root_path, alert: "Debes registrarte o iniciar sesión para solicitar materiales")
      return
    end
    @joyas = current_usuario.joyas.where.not(estado: "Vendido")
  end

  def pagar
    @joyas = current_usuario.joyas
    @joyas.where(estado: "Aceptado").update_all(estado: "Vendido")
    @joyas.where(estado: "Rechazado").destroy_all
    render("pagar")
  end

end

