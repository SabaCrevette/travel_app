class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png heic webp]
  end

  def default_url
    'sample'
  end

  # 画像をリサイズしてからWEBP形式に変換
  process resize_to_fit: [400, 200]
  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format 'webp'
      img
    end
  end

  # 拡張子を.webpで保存
  def filename
    "#{super.chomp(File.extname(super))}.webp" if original_filename.present?
  end

  # 画像のリサイズなどの処理（resize_to_fillは必要であればトリミングを行う。fitはアスペクト比維持）
  # version :thumb do
  #   process resize_to_fit: [200, 100]
  #   process :convert_to_webp
  # end
end
