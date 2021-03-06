class Post < ActiveRecord::Base
	has_many :comments

  # # Generate the thumbnail on validate so we can return errors on failure
  # validate :generate_thumbnail_from_url

  # # Cleanup temp files when we are done
  # after_save :cleanup_temp_thumbnail
  
  # # Generate a thumbnail from the remote URL
  # def generate_thumbnail_from_url

  #   # Skip thumbnail generation if:
  #   # a) there are already other validation errors
  #   # b) an image was manually specified
  #   # c) an image is already stored and the URL hasn't changed
  #   skip_generate = self.errors.any? || (self.image_changed? ||
  #       (self.image_stored? && !self.url_changed?))
  #   # p "*** generating thumbnail: #{!skip_generate}"
  #   return if skip_generate

  #   # Generate and assign an image or set a validation error
  #   begin
  #     tempfile = temp_thumbnail_path
  #     cmd = "wkhtmltoimage --quality 95 \"#{self.url}\" \"#{tempfile}\""
  #     # p "*** grabbing thumbnail: #{cmd}"
  #     system(cmd) # sometimes returns false even if image was saved
  #     self.image = File.new(tempfile) # will throw if not saved
  #   rescue => e
  #     # p "*** thumbnail error: #{e}"
  #     self.errors.add(:base, "Cannot generate thumbnail. Is your URL valid?")
  #   ensure
  #   end
  # end

  # # Return the absolute path to the temporary thumbnail file
  # def temp_thumbnail_path
  #   File.expand_path("#{self.url.parameterize.slice(0, 20)}.jpg", Dragonfly.app.datastore.root_path)
  # end

  # # Cleanup the temporary thumbnail image
  # def cleanup_temp_thumbnail
  #   File.delete(temp_thumbnail_path) rescue 0
  # end
end
