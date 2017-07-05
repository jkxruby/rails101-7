class GroupsController < ApplicationController


def new
  @group = Group.new
end

def index
  @groups = Group.all
end

def show
  @group = Group.find(params[:id])
end

def edit
  @group = Group.find(params[:id])
end

def create
  @group = Group.new(group_params)
  if @group.save
    redirect_to groups_path
  else
    render :new
  end
end

def update
  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to groups_path ,notice: "更新了，但要快速完成rails101！"
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  @group.destroy
  redirect_to groups_path,alert: "删了，但要快速开发rails101！"
end

private

def group_params
  params.require(:group).permit(:title, :description)
end



end