class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Route to user page on sign-in
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || user_path(current_user)
  end

  def after_updated_account_path_for(resource)
  	edit_user_registration_path
  end

  # Sets user
  def set_user
    if current_user&.id
      @user = User.friendly.find(current_user.id)
    else
      redirect_to new_user_registration_path, errors: 'You need to sign in or sign up before continuing.'
    end
  end

  def set_current_user
    if current_user&.id
      @user = User.friendly.find(current_user.id)
    else
      redirect_to new_user_registration_path, errors: 'You need to sign in or sign up before continuing.'
    end
  end


  # Sets user
  def set_user
    if current_user&.id
      @user = User.find(current_user.id)
    else
      redirect_to new_user_registration_path, errors: 'You need to sign in or sign up before continuing.'
    end
  end

  def set_current_user
    if current_user&.id
      @user = User.find(current_user.id)
    else
      redirect_to new_user_registration_path, errors: 'You need to sign in or sign up before continuing.'
    end
  end


  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  protected

  # Allow additional parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[type affiliation first_name last_name username image_url])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[type affiliation first_name last_name username email username image_url])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end


end
