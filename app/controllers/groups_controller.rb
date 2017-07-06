class GroupsController < ApplicationController
before_action :authenticate_user! , only: [:new, :edit, :destroy, :update, :create, :join, :quit]
before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

def new
  @group = Group.new
end

def index
  @groups = Group.all
end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
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

def join
  @group = Group.find(params[:id])
  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "加入本版成功！但要快速开发！"
  else
    flash[:warning] = "你已经是本讨论版成员了！"
  end
  redirect_to group_path(@group)
end

def quit
  @group = Group.find(params[:id])
  if current_user.is_member_of?(@group)
    current_user.quit!(@group)
    flash[:alert] = "已经退出本讨论版！"
  else
    flash[:warning] = "本来就不是，怎么退！快速开发！"
  end
  redirect_to group_path(@group)
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
