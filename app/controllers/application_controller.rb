class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session


  # - Methods

  # Public: structure the response for a successful request to create a resource.
  # 
  # opts - a Hash contaning any extra information to send along with the response  
  # 
  # Returns a HTTP response with status 201.
  def render_created(opts = {})
    render json: opts, root: false, status: :created
  end

  # Public: structure the response for a failed request to create a resource.
  # 
  # model - the Object attempted to create
  # opts - a Hash contaning any extra information to send along with the response
  # 
  # Returns a HTTP response with status 422.
  def render_unprocessable(model, opts = {})
    render json: opts.merge(errors: model.errors), status: :unprocessable_entity
  end

  # Public: determine what action to take when a resource is not found.
  # 
  # Returns HTTP response with status 404.
  def render_not_found
    head :not_found
  end
end
