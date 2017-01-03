class LanguagesController < ApplicationController
  def index
    # This will have to be modified once a User model exists
    languages = Language.all
    render json: languages
  end

  def show
    language = Language.find_by(id: params[:id])
    if language
      render json: language
    else
      render status: :not_found, nothing: true
    end
  end

  def create
    logger.info(">>>>>>>> #{request.body.read}")
    logger.info(">>>>>>>> #{params}")
    language = Language.new(language_params)
    language.save
    render json: {"id": language.id}, status: :created
  end

  private

  def language_params
    params.require(:language).permit(:id, :name, :description)
  end
end
