# frozen_string_literal: true
class ChatroomsController < ApplicationController
  
  def index
    unless current_usuario
      redirect_to(root_path, alert: "No puedes ver chats como invitado, regístrate!") unless current_usuario
        return
    end
    @chatrooms_creados = Chatroom.where(creador: current_usuario.nombre_usuario)
    @chatrooms_entrantes = Chatroom.where(remitente: current_usuario.nombre_usuario)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @mensaje= Mensaje.new 
    @mensajes = @chatroom.mensajes
  end
  
  def new
    redirect_to(root_path, alert: "Debes estar registrado para crear chats.") unless current_usuario
      @chatroom = Chatroom.new
      if params[:seller].present?
        @user = Usuario.find_by(nombre_usuario: params[:seller])
      else
        @user = Usuario.where(tipo_usuario: :admin).order("RANDOM()").limit(1).first
      end

      if params[:support].present?
        @tipo_chat = params[:support]
      else
        @tipo_chat = true
      end
      
      if @user.nil?
        redirect_to(chatrooms_path, alert: "No existen administradores actualmente.")
      end
  end

  def update
    @chatroom = Chatroom.find(params[:id])
    if @chatroom.update(estado: "Cerrado")
      redirect_to(chatrooms_path, notice: "Conversación cerrada")
    else
      redirect_to(chatrooms_path, alert: "Este chat no se pudo cerrar!")
    end
  end
  
  def create
    @chatroom = Chatroom.new(chatroom_params)

    if @chatroom.save
      redirect_to(@chatroom, notice: "Chatroom was successfully created.")
    else
      render(:new)
    end
  end
  
    private
  
  def chatroom_params
    params.require(:chatroom).permit(:motivo, :soporte, :remitente, :creador, :estado)
  end
end