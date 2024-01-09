class TagAssigner
  def initialize(post, tag_names)
    @post = post
    @tag_names = tag_names.uniq
  end

  def assign_new
    # 新しいタグを割り当てる処理。既存のタグは変更しない。
    tag_names.each do |tag_name|
      @post.tags << Tag.find_or_create_by(name: tag_name) unless @post.tags.exists?(name: tag_name)
    end
  end

  def assign_with_removal
    current_tags = @post.tags.pluck(:name)

    # 新しく追加されたタグを関連付け
    (tag_names - current_tags).each do |new_tag_name|
      @post.tags << Tag.find_or_create_by(name: new_tag_name)
    end

    # 削除されたタグを関連付けから削除
    (current_tags - tag_names).each do |old_tag_name|
      @post.tags.delete(Tag.find_by(name: old_tag_name))
    end
  end

  private

  attr_reader :tag_names
end
