class GroupsController < ApplicationController
before_action :authenticate_user! , only: [:new, :edit, :destroy, :update, :create]
before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

def new
  @group = Group.new
end

def index
  @groups = Group.all
end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.recent 
end

def edit
end

def create
  @group = Group.new(group_params)
  @group.user = current_user
  if @group.save
    redirect_to groups_path
  else
    render :new
  end
end

def update
  if @group.update(group_params)
    redirect_to groups_path ,notice: "更新了，但要快速完成rails101！"
  else
    render :edit
  end
end

def destroy
  @group.destroy
  redirect_to groups_path,alert: "删了，但要快速开发rails101！"
end

private

def group_params
  params.require(:group).permit(:title, :description)
end

def find_group_and_check_permission
  @group = Group.find(params[:id])

  if current_user != @group.user
    redirect_to root_path, alert: "you have no permission"
  end
end


end
