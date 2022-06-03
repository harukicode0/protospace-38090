class CommentsController < ApplicationController
  def create
    @comment = Comment.new(commentIsOk)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = Prototype.find(params[:prototype_id])
      render template: "prototypes/show"
    end
  end

  private
  def commentIsOk
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
