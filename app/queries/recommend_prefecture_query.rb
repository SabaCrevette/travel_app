# app/queries/recommend_prefecture_query.rb
# プロフィールの居住都道府県登録に基づいたレコメンド
class RecommendPrefectureQuery
  def initialize(user)
    @user = user
  end

  def call
    if @user.prefecture_id.present?
      # 居住都道府県が属するregionの他の都道府県の投稿をランダムで取得
      region_prefecture_ids = Prefecture.where(region_id: @user.prefecture.region_id).pluck(:id)
      recommended_post = Post.open.where(prefecture_id: region_prefecture_ids).where.not(user_id: @user.id).order(Arel.sql('RANDOM()')).first
      return recommended_post if recommended_post
    end

    # 居住都道府県が未登録、または該当する投稿がない場合、投稿していない都道府県の投稿をランダムで取得
    posted_prefecture_ids = @user.posts.select(:prefecture_id).distinct.pluck(:prefecture_id)
    recommended_post = Post.open.where.not(prefecture_id: posted_prefecture_ids).order(Arel.sql('RANDOM()')).first
    return recommended_post if recommended_post

    # どの条件にも該当しない場合
    '投稿がありません'
  end
end
