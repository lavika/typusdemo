class StarsController < ApplicationController
	def index
		@stars = Star.all
	end

	def new
		@star = Star.new
	end

	 def create
    	@star = Star.new(star_params)
    # @object = LinkThumbnailer.generate('http://google.com')
    # pp @object.title
    respond_to do |format|
      if @star.save
        format.html { redirect_to @star, notice: 'Star was successfully created.' }
        format.json { render :show, status: :created, location: @star }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  	@star = Star.find(params[:id])
  end
  private

  def star_params
      params.require(:star).permit(:first_name, :last_name, :email)
    end
end
