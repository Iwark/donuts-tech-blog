# encoding: utf-8

class ArticleImageUploader < BaseImageUploader

  # 最大サイズを指定
  process :resize_to_fit => [640, 640]

  version :small do
    process :resize_to_fit => [300, 300]
  end

end
