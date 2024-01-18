class PrefecturesController < ApplicationController
  def areas
    # 都道府県に紐づく一意のエリアだけを取得
    @areas = AreaMapping.where(prefecture_id: params[:id]).includes(:area).map(&:area).uniq
    render json: @areas
  end
end
