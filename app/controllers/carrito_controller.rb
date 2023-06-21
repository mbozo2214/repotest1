# frozen_string_literal: true
require "prawn"
class CarritoController < ApplicationController
  before_action :set_publicacion, only: [:create, :destroy]
  def index
    unless current_usuario
      redirect_to(root_path, alert: "Debes registrarte para hacer un carrito!")
      return
    end
    @joyas = current_usuario.joyas.where.not(estado: "Vendido")
  end

  def generar_pdf_carrito
    @joyas = current_usuario.joyas

    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new(page_size: "A4")


        pdf.fill_color("000000")
        pdf.fill_rectangle([0, pdf.bounds.height], pdf.bounds.width, pdf.bounds.height)

        @joyas.each do |joya|
          pdf.move_down(20)

          pdf.bounding_box([pdf.bounds.left, pdf.cursor], width: pdf.bounds.width) do

            image_path = joya.publicacion.imagen.path
            if File.exist?(image_path)
              pdf.image(image_path, fit: [200, 200], position: :center)
            end

            pdf.move_down(10)

            pdf.text("Nombre: #{joya.publicacion.nombre}", size: 12, align: :center, color: "FFFFFF")
            pdf.text("Descripción: #{joya.publicacion.descripcion}", size: 12, align: :center, color: "FFFFFF")

          end

          pdf.move_down(20)
        end

        temp_pdf_file = "#{Rails.root}/tmp/publicaciones.pdf"
        pdf.render_file(temp_pdf_file)

        send_file(temp_pdf_file, filename: "publicaciones.pdf", type: "application/pdf", disposition: "attachment")
      end
    end
  end

  def pagar
    @joyas = current_usuario.joyas
    @joyas.where(estado: "Aceptado").update_all(estado: "Vendido")
    @joyas.where(estado: "Rechazado").destroy_all
    render("pagar")
  end

end

