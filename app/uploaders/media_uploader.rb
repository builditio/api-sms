# encoding: utf-8

class MediaUploader < CarrierWave::Uploader::Base

  storage :aws


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end


end
