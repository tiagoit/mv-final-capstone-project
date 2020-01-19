class FavouritesController < ApplicationController
  before_action :authorize_request

  # GET /favourites
  def index
    render json: @current_user.favourites, status: :ok
  end

  # POST /favourites
  def create
    @favourite = @current_user.favourites.build(provider_id: params[:provider_id])
    if @favourite.save
      render json: @favourite, status: :created
    else
      render json: { errors: @favourite.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /favourites/{id}
  def destroy
    @favourite = Favourite.find_by(user_id: @current_user.id, provider_id: params[:id])
    @favourite.destroy if @favourite
  end

  # def favourite_params
  #   params.require(:favourite).permit(:provider_id)
  # end

end
