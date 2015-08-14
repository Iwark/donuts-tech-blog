# encoding: utf-8

class BaseImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "images/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Rotates the image based on the EXIF Orientation
  process :fix_exif_rotation
  def fix_exif_rotation
    manipulate! do |img|
      img.auto_orient
      yield(img) if block_given?
      img
    end
  end

  process :remove_animation

  def remove_animation
    manipulate! do |img|
      if img.mime_type.match /gif/
        img.collapse!
      end
      img
    end
  end

  # process :fix_resize_issue_with_gif

  # def fix_resize_issue_with_gif
  #   if file.extension.downcase == 'gif' && version_name.blank?
  #     list = ::Magick::ImageList.new.from_blob file.read

  #     if list.size > 1
  #       list = list.coalesce
  #       File.open(current_path, 'wb') { |f| f.write list.to_blob }
  #     end
  #   end
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    @name ||= "#{timestamp}-#{super}" if original_filename.present? and super.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

end
