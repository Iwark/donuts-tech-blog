# encoding: utf-8

class ArticleImageUploader < BaseImageUploader

  # 最大サイズを指定
  process :resize_to_fill => [640, 640]

end
