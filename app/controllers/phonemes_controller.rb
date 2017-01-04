class PhonemesController < ApplicationController
  before_action :find_language, only: [:add, :remove]

  def index
    # phonemes = Phoneme.all
    # render json: phonemes
    language_phonemes = Language.includes(:phonemes).find(params[:language_id]).phonemes
    render json: language_phonemes
  end

  def add
    @phoneme.language_ids << @language.id
  end

  def remove
    @phoneme.language_ids.delete(@language.id)
  end

  private

  def phoneme_params
    params.require(:phoneme).permit(:ipa, :voice, :consonant, :place, :manner, :high, :front, :low, :back, :syllabic, language_ids: [])
  end

  def find_language
    @language = Language.find_by(id: params[:language_id])
  end

  def find_phoneme
    @phoneme = Phoneme.find_by(id: params[:id])
  end

end
