class WordsController < ApplicationController
  before_action :find_word, only: [:show, :update, :destroy]

  def index
    words = Word.all
    render json: words
  end

  def show
    if @word.present?
      render json: @word
    else
      render status: :not_found, nothing: true
    end
  end

  def create
    logger.info(">>>>>>>> #{request.body.read}")
    logger.info(">>>>>>>> #{params}")
    word = Word.new(word_params)

    if word.save
      render json: word, status: :created
    else
      render status: :bad_request, nothing: true
    end
  end

  def update
    @word.assign_attributes(word_params)
    if @word.save
      render json: @word
    else
      render status: :bad_request, nothing: true
    end
  end

  def destroy
    @word.destroy
    render json: [], status: :no_content
  end

  private

  def word_params
    params.require(:word).permit(:id, :form, :translation, :language_id)
  end

  def find_word
    @word = Word.find_by(id: params[:id])
  end
end
