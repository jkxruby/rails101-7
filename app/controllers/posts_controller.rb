class PostsController < ApplicationController

def edit
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
end

def new
  @group = Group.find(params[:group_id])
  @post = Post.new
end

def index
  @group = Group.find(params[:group_id])
  @posts = Post.all
end

def create
  @group = Group.find(params[:group_id])
  @post = Post.new(post_params)
  @post.group = @group
  @post.user = current_user
  if @post.save
    redirect_to group_path(@group)
  else
    render :new
  end
end

def update
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  @post.group = @group
  if @post.update(post_params)
    redirect_to group_path(@group), notice: "更新成功，但要快速开发！"
  else
    render :edit
  end
end

private
def post_params
  params.require(:post).permit(:content)
end


end
