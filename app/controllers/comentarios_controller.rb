# frozen_string_literal: true
class ComentariosController < ApplicationController
  before_action :set_publicacion, only: [:create, :destroy]
    
  def create
    @publicacion = Publicacion.find(params[:publicacion_id])
      @comentario = @publicacion.comentarios.create(comentario_params)
      if @comentario.save
        redirect_to(publicacion_path(@publicacion))
      else
        render(json: @comentario.errors, status: :unprocessable_entity)
      end
  end
  
  def destroy
    @publicacion = Publicacion.find(params[:publicacion_id])
    @comentario = @publicacion.comentarios.find(params[:id])

    redirect_to(
      root_path, 
      alert: "Debes ser dueño del comentario o administrador para poder eliminarlo.") \
      unless current_usuario.admin? || (current_usuario == @comentario.usuario)

    @comentario.destroy
    redirect_to(publicacion_path(@publicacion))
  end
  
    private
  def set_publicacion
    @publicacion = Publicacion.find(params[:publicacion_id])
  end
    
  def comentario_params
    params.require(:comentario).permit(:contenido, :calificacion, :usuario_id)
  end
end