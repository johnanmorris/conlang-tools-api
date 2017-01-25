class LanguagesController < ApplicationController
  before_action :find_language, except: [:index, :create]

  def index
    languages = Language.all
    render json: languages
  end

  def show
    if @language.present?
      render json: @language
    else
      render status: :not_found, nothing: true
    end
  end

  def create
    logger.info(">>>>>>>> #{request.body.read}")
    logger.info(">>>>>>>> #{params}")
    language = Language.new(language_params)
    if language.save
      render json: language, status: :created
    else
      render status: :bad_request, nothing: true
    end
  end

  def update
    @language.assign_attributes(language_params)
    if @language.save
      render json: @language
    else
      render status: :bad_request, nothing: true
    end
  end

  def destroy
    @language.destroy
    render json: [], status: :no_content
  end

  private

  def language_params
    params[:language][:phoneme_ids] ||=[]
    params.require(:language).permit(:id, :name, :description, {phoneme_ids: []})
  end

  def find_language
    @language = Language.find_by(id: params[:id])
  end
end
