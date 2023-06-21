# frozen_string_literal: true
require "chunky_png"

class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process :resize_medium
  end

  version :thumb do
    process :resize_thumb
  end

  version :thumb1 do
    process :resize_thumb1
  end

  def extension_allowlist
    ["png"]
  end

  def filename
    "something.png" if original_filename
  end

  private

  def manipulate!
    return if !file

    image = ChunkyPNG::Image.from_file(file.path)
    image_resized = resize_image(image, version_dimensions[0], version_dimensions[1]) if version_dimensions
    image_resized ||= image
    image_resized.save(file.path)
  end

  def resize_image(image, width, height)
    image.resample_bilinear!(width, height)
    image
  end

  def resize_medium
    process_resize_to_fit(800, 800)
  end

  def resize_thumb
    process_resize_to_fit(400, 400)
  end

  def resize_thumb1
    process_resize_to_fit(100, 100)
  end

  def process_resize_to_fit(width, height)
    image = ChunkyPNG::Image.from_file(file.path)
    image_resized = resize_image(image, width, height)
    image_resized.save(file.path)
  end

  def version_dimensions
    case version_name
    when :medium then [800, 800]
    when :thumb then [400, 400]
    when :thumb1 then [100, 100]
    end
  end
end
