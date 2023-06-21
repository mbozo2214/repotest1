# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :usuarios, 
    controllers: { sessions: "usuarios/sessions", registrations: "usuarios/registrations" }, 
    path: "", 
    path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  devise_scope :usuario do
    get "perfil_opciones", to: "usuarios/registrations#opciones", as: "perfil_opciones"
    get "joyas_compradas", to: "usuarios/registrations#joyas_compradas", as: "joyas_compradas"
  end

  root "hello#index"
  get "registrarse", to: "usuarios#nuevo"
  post "usuario", to: "usuarios#create"
  get "perfil/:id", to: "usuarios#perfil", as: "perfil"
  patch "perfil/:id", to: "usuarios#update"
  delete "perfil/:id", to: "usuarios#destroy", as: "eliminar_perfil"
  delete "publicacions/:id/eliminar", to: "publicacions#destroy", as: "eliminar_publicacion"
  get "publicacions/:id/eliminar", to: "publicacions#confirmar_eliminacion", as: "confirmar_eliminacion"
  patch "publicacions/:id/eliminar", to: "publicacions#destroy", as: "eliminar_confirmacion_publicacion_path"
  
  # resources :publicacions
  resources :publicacions do
    resources :comentarios, only: [:create, :destroy]
  end
  resources :publicacions do
    resources :joyas, only: [:create, :destroy, :update]
  end
  resources :chatrooms
  resources :chatrooms do
    resources :mensajes, only: [:create, :destroy]
  end

  get "crear_joya", to: "joyas#nueva_joya"
  post "joya", to: "joyas#create"
  get "joya_creada/:id", to: "joyas#joya_creada", as: "joya_creada"
  patch "joya_creada/:id", to: "joyas#update"
  delete "joya_creada/:id", to: "joyas#destroy", as: "eliminar_joya_creada"
  get "/carrito", to: "carrito#index", as: "carrito_path"
  get "generar_pdf_carrito", to: "carrito#generar_pdf_carrito", as: "generar_pdf_carrito"

  post "solicitud_compra", to: "joyas#solicitud_compra", as: "solicitud_compra"
  patch "joyas/:id/solicitud_compra", to: "joyas#solicitud_compra", as: "solicitud_compra_joya"
  get "solicitudes_compra", to: "publicacions#solicitudes_compra", as: "solicitudes_compra"
  resources :joyas do
    member do
      patch :aceptar_solicitud
      patch :rechazar_solicitud
    end
  end
  post "pagar", to: "carrito#pagar", as: "pagar"

end
