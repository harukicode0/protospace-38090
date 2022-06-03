class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_image)
    if @prototype.save
      redirect_to root_path
   else
     render new_prototype_path
   end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    # binding.pry
    @comments = @prototype.comments.includes(:prototype)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_image)
      redirect_to prototype_path(prototype)
    else
      redirect_to edit_prototype_path(prototype)
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
    def prototype_image
      params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
    end

    def move_to_index
      unless  Prototype.find(params[:id]).user.id == current_user.id
        redirect_to action: :index
      end
    end
end
