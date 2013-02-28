class PhotoUploader < Uploader

  version :small_thumb do
    process :resize_to_limit => [50, 50]
  end
end
