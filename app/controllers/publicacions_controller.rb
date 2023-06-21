# frozen_string_literal: true
class PublicacionsController < ApplicationController
  def index
    redirect_to(root_path, alert: "No puedes ver publicaciones como invitado, regístrate!") unless current_usuario
      @publicacions = Publicacion.all
  end

  def new
    redirect_to(
      root_path, 
      alert: "Debes ser administrador para crear publicaciones.") unless \
      (current_usuario.admin? || current_usuario.vendedor?)
      @publicacion = Publicacion.new
  end

  def create
    @publicacion = Publicacion.new(publicacion_params)
      if @publicacion.save
        redirect_to(publicacions_path)
      else
        render("new")
      end
  end
    
  def edit
    redirect_to(
      root_path, 
      alert: "Debes ser administrador o dueño de la publicación para editar esta publicación.") unless \
      (current_usuario.admin? || Publicacion.find(params[:id]).vendedor == current_usuario)
      @publicacion = Publicacion.find(params[:id])
  end

  def update
    @publicacion = Publicacion.find(params[:id])
      if @publicacion.update(publicacion_params)
        redirect_to(publicacions_path)
      else
        render("edit")
      end
  end

  def show
    @publicacion = Publicacion.find(params[:id])
    @comentario = Comentario.new
    @comentarios = @publicacion.comentarios 
    @joya = Joya.new
    @joyas = @publicacion.joyas
  end

  def destroy
    @publicacion = Publicacion.find(params[:id])
    @publicacion.destroy
    redirect_to(publicacions_path)
  end

  def confirmar_eliminacion
    redirect_to(
      root_path, 
      alert: "Debes ser administrador para eliminar publicaciones.") unless \
      (current_usuario.admin? || Publicacion.find(params[:id]).vendedor == current_usuario)
      @publicacion = Publicacion.find(params[:id])
  end

  def solicitudes_compra
    if current_usuario.respond_to?(:admin?) && current_usuario.admin? \
      || current_usuario.respond_to?(:vendedor?) && current_usuario.vendedor?
      @solicitudes = Joya.where(estado: "Pendiente")
      @aceptados = Joya.where(estado: "Aceptado")
      @rechazados = Joya.where(estado: "Rechazado")
      @vendidos = Joya.where(estado: "Vendido")
    else
      redirect_to(root_path, alert: "No tienes acceso a esta página.")
    end
  end

  private
      
  def publicacion_params
    params.require(:publicacion).permit(:vendedor, :nombre, :tipo_joya, :precio, :descripcion, :color, :imagen)
  end

end
