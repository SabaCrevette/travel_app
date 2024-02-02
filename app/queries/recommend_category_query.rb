# app/queries/recommend_category_query.rb
# プロフィールの旅の嗜好に基づいたレコメンド
class RecommendCategoryQuery
  def initialize(user)
    @user = user
  end

  def call
    if @user.category_id.present?
      # category_idに一致するtag_idを持つpostをランダムで1件取得
      tag_ids = CategoryTag.where(category_id: @user.category_id).pluck(:tag_id)
      recommended_post = Post.open.joins(:post_tags).where(post_tags: { tag_id: tag_ids }).where.not(user_id: @user.id).order(Arel.sql('RANDOM()')).first
      return recommended_post if recommended_post
    end

    # category_idが未登録の場合、自分の投稿以外をランダムで1件表示
    Post.open.where.not(user_id: @user.id).order(Arel.sql('RANDOM()')).first || '投稿がありません'
  end
end
