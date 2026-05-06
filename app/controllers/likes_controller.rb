class LikesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_photo

  def create
    current_user.likes.find_or_create_by!(photo: @photo)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@photo, :like),
          partial: "photos/like_button",
          locals: { photo: @photo }
        )
      end
      format.html { redirect_to photos_path }
    end
  end

  def destroy
    current_user.likes.find_by!(photo: @photo).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@photo, :like),
          partial: "photos/like_button",
          locals: { photo: @photo }
        )
      end
      format.html { redirect_to photos_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
