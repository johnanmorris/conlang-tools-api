class PhonemesController < ApplicationController

  def index
    phonemes = Phoneme.all
    render json: phonemes
  end

  private

  def phoneme_params
    params.require(:phoneme).permit(:ipa, :voice, :consonant, :place, :manner, :high, :front, :low, :back, :syllabic)
  end
end
