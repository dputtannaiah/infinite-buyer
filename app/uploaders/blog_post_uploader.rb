class BlogPostUploader < Uploader
  version :blog do
    process :resize_to_fit => [150, 150]
  end
end