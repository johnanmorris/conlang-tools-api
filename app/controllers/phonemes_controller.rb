class PhonemesController < ApplicationController
  before_action :find_language, only: [:add, :remove]

  def index
    language_phonemes = Language.includes(:phonemes).find(params[:language_id]).phonemes
    render json: language_phonemes
  end

  private

  def phoneme_params
    params.require(:phoneme).permit(:ipa, :voice, :consonant, :place, :manner, :high, :front, :low, :back, :syllabic)
  end

  def find_language
    @language = Language.find_by(id: params[:language_id])
  end

  def find_phoneme
    @phoneme = Phoneme.find_by(id: params[:id])
  end

end
