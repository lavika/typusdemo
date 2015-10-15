class Scrape < ActiveRecord::Base

   attr_accessible :url

   serialize :images   # Store images array as YAML in the database

   validates :url, presence: true, :format => URI::regexp(%w(http https))

   before_save :scrape_with_grabbit

   private

   def scrape_with_grabbit

       # I highly recommend passing the following call off to a Resque worker, or Delayed Job queue.
       # The reason is that Grabbit will attempt to access the remote URL. If there is a network problem,
       # or the remote URL is unavailable, the following line could hang up your Rails process.

       data = Grabbit.url(url)

       if data
           self.title = data.title
           self.description = data.description
           self.images = data.images
       end

   end
end