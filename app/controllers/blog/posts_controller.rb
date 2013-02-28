class Blog::PostsController < ApplicationController
  layout 'bootstrap', :except => [:index, :show]
  
  before_filter :authenticate_admin!, :except => [:index, :show]

  # GET /blog/posts
  # GET /blog/posts.xml
  def list
    @blog_posts = Blog::Post.all
  end

  def index
    where = []
    where << "deleted_at is NULL"
    if(params[:date].to_date rescue nil)
      blog_posts = Blog::Post.between_dates params[:date], params[:date].to_date.end_of_month.to_s
      @blog_posts = blog_posts.page params[:page]
    else
      @blog_posts = Blog::Post.where(where.join(" AND ")).page params[:page]
    end

    respond_to do |format|
      format.html {render :layout => 'blog'}
      format.xml { render :xml => @blog_posts }
    end
  end

  # GET /blog/posts/1
  # GET /blog/posts/1.xml
  def show
    begin
      @blog_post = Blog::Post.find(params[:id])
      @blog_comment = Blog::Comment.new params[:blog_comments]
      @blog_post.update_views
    rescue ActiveRecord::RecordNotFound
      request.env['HTTP_HOST'] = request.env['HTTP_HOST'].sub("blog.","")
      redirect_to "http://#{request.env['HTTP_HOST'] + request.env['REQUEST_URI']}"
      return
    end
    respond_to do |format|
      format.html {render :layout => 'blog'}
      format.xml { render :xml => @blog_post }
    end
  end

  # GET /blog/posts/new
  # GET /blog/posts/new.xml
  def new
    @blog_post = Blog::Post.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @blog_post }
    end
  end

  # GET /blog/posts/1/edit
  def edit
    @blog_post = Blog::Post.find(params[:id])
  end

  # POST /blog/posts
  # POST /blog/posts.xml
  def create
    @blog_post = Blog::Post.new(params[:blog_post])

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to(list_blog_posts_url, :notice => 'Post was successfully created.') }
        format.xml { render :xml => @blog_post, :status => :created, :location => @blog_post }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @blog_post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blog/posts/1
  # PUT /blog/posts/1.xml
  def update
    @blog_post = Blog::Post.find(params[:id])

    respond_to do |format|
      if @blog_post.update_attributes(params[:blog_post])
        format.html { redirect_to(list_blog_posts_url, :notice => 'Post was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @blog_post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def activate
    @blog_post = Blog::Post.find(params[:id])
    @blog_post.activate!

    respond_to do |format|
      format.html { redirect_to(list_blog_posts_url, :notice => 'Post was successfully updated.') }
      format.xml { render :xml => @blog_post }
    end
  end

  def deactivate
    @blog_post = Blog::Post.find(params[:id])
    @blog_post.deactivate!

    respond_to do |format|
      format.html { redirect_to(list_blog_posts_url, :notice => 'Post was successfully updated.') }
      format.xml { render :xml => @blog_post }
    end
  end

  # DELETE /blog/posts/1
  # DELETE /blog/posts/1.xml
  def destroy
    @blog_post = Blog::Post.find(params[:id])
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to(list_blog_posts_url) }
      format.xml { head :ok }
    end
  end
end
