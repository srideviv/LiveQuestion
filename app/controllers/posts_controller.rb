class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.find(:all,:order => "numVotes DESC, created_at DESC", :limit => "5")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/search/
 def search
    @posts = Post.find(:all, :conditions => "question LIKE '%#{params[:inp]}%'")
    #@posts = Post.where("question LIKE ?","%"+(params[:inp])+"%")
    if @posts.length != 0
      respond_to do |format|
        format.html # search.html.erb
        format.json { render json: @posts }
      end
    else
       flash[:alert] = "No posts found for user name input: #{params[:inp]} ! Please try again."
       redirect_to :controller => "posts", :action => "index"
    end
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @user= session[:current_user_id]
    @post.numVotes=0
    session[:post_id] = @post.id
    if @user != nil
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @post }
      end
    else
      flash[:alert] = "You have to login to post a question"
      redirect_to :controller => "posts", :action => "index"
    end

  end

  # GET posts/report
  def report
    @method = params[:id]
    @posts = Post.all
    respond_to do |format|
        format.html # report.html.erb
        format.json { render json: @posts }
    end
  end

  # @return [uname]
  def find_user
    if @post.user_id == @user.id
      @user.uname
    end
  end
  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = session[:current_user_id]
    @post.numVotes=0
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.user_id = session[:current_user_id]
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    vote = Vote.find( :all, :conditions => ["post_id = ?", @post.id])
    for n in 0 ... vote.size do
         Vote.destroyCascade(vote[n])
    end
    comment = Comment.find(:all, :conditions => ["post_id = ?", @post.id])
    for n in 0 ... comment.size do
             Comment.destroyCascade(comment[n])
    end
    commentvote = CommentVote.find(:all, :conditions => ["post_id = ?", @post.id])
    for n in 0 ... commentvote.size do
             CommentVote.destroyCascade(commentvote[n])
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end         
end
