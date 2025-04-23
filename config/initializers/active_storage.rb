# config/initializers/active_storage.rb

# Use MiniMagick para gerar variants (thumbnails, crops, etc)
Rails.application.config.active_storage.variant_processor = :mini_magick
