class Api::V1::LinksController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    link = current_user.links.new(new_link_params)

    if link.save
      render partial: 'links/link',
                      locals: { link: link },
                      layout: false
    else
      render json: { errors: link.errors.full_messages }, status: 500
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  private

  def link_params
    params.permit(:read)
  end

  def new_link_params
    params.require(:link).permit(:url, :title)
  end

  def authenticate
    render json: { errors: ['Must be logged in to create a link'] } unless current_user
  end

end
