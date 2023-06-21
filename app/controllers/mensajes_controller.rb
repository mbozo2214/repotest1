# frozen_string_literal: true
class MensajesController < ApplicationController
  before_action :set_chatroom, only: [:create, :destroy]
  
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @mensaje = @chatroom.mensajes.create(mensaje_params)
    if @mensaje.save
      redirect_to(chatroom_path(@chatroom))
    else
      render(json: @mensaje.errors, status: :unprocessable_entity)
    end
  end
  
  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
  
  def mensaje_params
    params.require(:mensaje).permit(:body, :usuario_id)
  end
end