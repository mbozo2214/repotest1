# frozen_string_literal: true
class JoyasController < ApplicationController
  before_action :set_publicacion, only: [:create, :destroy]

  def set_publicacion
    @publicacion = Publicacion.find(params[:publicacion_id])
  end

  def joya_params
    params.require(:joya).permit(:cantidad, :estado, :usuario_id)
  end

  def joya_creada
    @joya = Joya.find(params[:id])
  end

  def show
    @joya = Joya.find(params[:id]) 
      render(json: @joya)
  end

  def create
    @publicacion = Publicacion.find(params[:publicacion_id])
      @joya = @publicacion.joyas.create(joya_params)
      if @joya.save 
        flash[:success] = "Joya creada con exito" 
          redirect_to(publicacion_path(@publicacion))
      else
        render(json: @joya.errors, status: :unprocessable_entity)
      end
  end

  def destroy
    @publicacion = Publicacion.find(params[:publicacion_id])
      @joya = @publicacion.joyas.find(params[:id])
      @joya.destroy
      redirect_to(carrito_path_url)
  end

  def update
    @publicacion = Publicacion.find(params[:publicacion_id])
      @joya = @publicacion.joyas.find(params[:id])
      if @joya.update(joya_params)
        @joya.update(joya_params)
          redirect_to(carrito_path_url, notice: "La cantidad ha sido actualizada correctamente.")
      else
        redirect_to(carrito_path_url, alert: "Hubo un error al actualizar la cantidad.")
      end
  end

  def editar
    @joya = Joya.find(params[:id])
  end

  def solicitud_compra
    @joya = Joya.find(params[:id])
    @joya.estado = "Pendiente"
  
    if @joya.save
      redirect_to(carrito_path_url, notice: "Solicitud de compra enviada con Ã©xito.")
    else
      redirect_to(carrito_path_url, alert: "Hubo un error al enviar la solicitud de compra.")
    end
  end

  def aceptar_solicitud
    @solicitud = Joya.find(params[:id])
    @solicitud.update(estado: "Aceptado")

    redirect_to(solicitudes_compra_path, notice: "Solicitud aceptada exitosamente.")
  end

  def rechazar_solicitud
    @solicitud = Joya.find(params[:id])
    @solicitud.update(estado: "Rechazado")

    redirect_to(solicitudes_compra_path, notice: "Solicitud rechazada exitosamente.")
  end

end