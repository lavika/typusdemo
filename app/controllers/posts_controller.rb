
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
 skip_before_filter :authenticate_user!, :only => [:show, :index, :add_reply]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @user = @post.user
    @flag = '0'
    begin
    @object = LinkThumbnailer.generate(@post.description)
    rescue LinkThumbnailer::Exceptions => error 
      @flag = '1'
    rescue URI::InvalidURIError => error
      @flag = '1'
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
    @posts = Post.all
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(post_params)
    @post.user = current_user.id
    # @object = LinkThumbnailer.generate('http://google.com')
    # pp @object.title
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  def add_reply
    
    @comment = Comment.find(params[:id])
    @reply = params[:reply]
    @comment.reply = @reply
    @comment.save
    render json: @reply.to_json
  end
   #  def auto_complete_for_table_thing # this is for the auto complete function in header.fbml.erb
   #     users = User.where(User.arel_table[:name].matches(params[:title].downcase + '%'))
   #     users.map! {|user| user = user.name.to_s}
   #     users = users.uniq
   #     users = users[0...10]
   #     render :text => "{fortext:#{params[:title].to_json},results:#{topics.to_json}}"
   # end
  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_users
    # p params
    # User.where()
    # binding.pry
    @users = User.where("name LIKE ?", "%#{params[:searchword]}%")
    # p @users
    @user_names = @users.all.collect(&:name)
    # @user_names = User.last(2).collect(&:name)
    render json: @user_names
    # @users = User.where(User.arel_table[:name].matches(params[:searchword] + "%")) 
    # @users.each do |user|
    #   user = user.name 
    #   p user
    #   user.to_s
    # end 
  end
  # DELETE /posts/1
  # DELETE /posts/1.json

  def delete_reply
    @comment = Comment.find(params[:id])
    @comment.reply = nil
    @comment.save
    render json: @comment.to_json
  end
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :searchword, :user)
    end
end
