# app/queries/recommend_post_query.rb
# 投稿データのタグに基づいたレコメンド
class RecommendPostQuery
  def initialize(user)
    @user = user
  end

  def call
    recommended_post_based_on_tags || recommended_post_based_on_prefecture || random_post || '投稿がありません'
  end

  private

  def recommended_post_based_on_tags
    tag_ids = @user.posts.joins(:post_tags).distinct.pluck('post_tags.tag_id').uniq
    return nil if tag_ids.empty?

    category_ids = CategoryTag.where(tag_id: tag_ids).pluck(:category_id).uniq
    matched_tag_ids = CategoryTag.where(category_id: category_ids).pluck(:tag_id)
    Post.open.joins(:post_tags).where(post_tags: { tag_id: matched_tag_ids }).where.not(user_id: @user.id).order(Arel.sql('RANDOM()')).first
  end

  def recommended_post_based_on_prefecture
    posted_prefecture_ids = @user.posts.select(:prefecture_id).distinct.pluck(:prefecture_id)
    Post.open.where.not(user_id: @user.id, prefecture_id: posted_prefecture_ids).order(Arel.sql('RANDOM()')).first
  end

  def random_post
    Post.open.where.not(user_id: @user.id).order(Arel.sql('RANDOM()')).first
  end
end
