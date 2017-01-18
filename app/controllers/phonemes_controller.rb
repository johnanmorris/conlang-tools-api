class PhonemesController < ApplicationController

  def index
    phonemes = Phoneme.all
    render json: phonemes
  end

  def show
    phoneme = Phoneme.find_by(id: params[:id])

    if phoneme.present?
      render json: phoneme
    else
      render status: :not_found, nothing: true
    end
  end

  private

  def phoneme_params
    params.require(:phoneme).permit(:id, :ipa, :voice, :consonant, :place, :manner, :high, :front, :low, :back, :syllabic)
  end
end
