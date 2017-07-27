class LinksController < ApplicationController
  before_action :authorize

  def index
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to links_path
    else
      flash[:failure] = @link.errors.full_messages
      redirect_to edit_link_path(@link)
    end
  end
  
  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
