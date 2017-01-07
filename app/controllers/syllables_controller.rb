class SyllablesController < ApplicationController
  before_action :find_language, only: [:index, :create, :update]
  before_action :find_syllable, only: [:update, :destroy]

  def index
    syllables = Syllable.where(language_id: @language.id)
    render json: syllables
  end

  def create
    logger.info(">>>>>>>> #{request.body.read}")
    logger.info(">>>>>>>> #{params}")
    syllable = Syllable.new(syllable_params)
    syllable.language_id = @language.id

    if syllable.save
      render json: syllable, status: :created
    else
      render status: :bad_request, nothing: true
    end
  end

  def update
    @syllable.assign_attributes(syllable_params)
    if @syllable.save
      render json: @language
    else
      render status: :bad_request, nothing: true
    end
  end

  def destroy
    @syllable.destroy
    render json: [], status: :no_content
  end

  private
  def syllable_params
    params.require(:syllable).permit(:id, :pattern, :language_id)
  end

  def find_language
    @language = Language.find(params[:language_id])
  end

  def find_syllable
    @syllable = Syllable.find(params[:id])
  end
end
