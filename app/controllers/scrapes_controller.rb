class ScrapesController < ApplicationController

 def create

   @scrape = Scrape.find_or_create_by_url(params[:scrape][:url])

   respond_to do |format|
     if @scrape.valid?
       format.js 
       # /app/views/scrapes/create.js.erb --> Use JS to display the preview to the user.
     else
       format.js { render "error" }    
       # /app/views/scrapes/error.js.erb --> Bad URL, Cancel the AJAX loading image or whatever...
     end
   end
 end

end