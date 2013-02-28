class Blog::CommentsController < ApplicationController
  layout 'bootstrap', :except => [:new]
  

  before_filter :authenticate_admin!, :except => [:create]

  # GET /blog/comments
  # GET /blog/comments.xml
  def index
    @blog_comments = Blog::Comment.joins(:post).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_comments }
    end
  end

  # GET /blog/comments/1
  # GET /blog/comments/1.xml
  def show
    @blog_comment = Blog::Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_comment }
    end
  end

  # GET /blog/comments/new
  # GET /blog/comments/new.xml
  def new
    @blog_comment = Blog::Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_comment }
    end
  end

  # GET /blog/comments/1/edit
  def edit
    @blog_comment = Blog::Comment.find(params[:id])
  end

  # POST /blog/comments
  # POST /blog/comments.xml
  def create
    @blog_comment = Blog::Comment.new(params[:blog_comment])
    @blog_post = @blog_comment.post
    respond_to do |format|
      if @blog_comment.save
        #Notifier.comment(@blog_comment).deliver
        blog_post = @blog_comment.post
        format.html { redirect_to(@blog_post, :notice => '     Thank you for Leaving a Reply. It has been sent to Admin review.') }
        format.xml  { render :xml => @blog_comment, :status => :created, :location => @blog_comment }
      else
        format.html { render :template => "/blog/posts/show" }
        format.xml  { render :xml => @blog_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blog/comments/1
  # PUT /blog/comments/1.xml
  def update
    @blog_comment = Blog::Comment.find(params[:id])

    respond_to do |format|
      if @blog_comment.update_attributes(params[:blog_comment])
        format.html { redirect_to(@blog_comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/comments/1
  # DELETE /blog/comments/1.xml
  def destroy
    @blog_comment = Blog::Comment.find(params[:id])
    @blog_comment.destroy

    respond_to do |format|
      format.html { redirect_to(blog_comments_url) }
      format.xml  { head :ok }
    end
  end
end
