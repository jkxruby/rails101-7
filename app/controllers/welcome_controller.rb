class WelcomeController < ApplicationController
  def index
    flash[:notice] = "第七遍做rails101了！必须实现超级快速开发！"
  end
end
