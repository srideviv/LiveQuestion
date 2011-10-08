class CommentVotesController < ApplicationController
  # GET /comment_votes
  # GET /comment_votes.json
def new
    comment_id = params[:comment_id]
    if session[:current_user_id]!=nil
      comment = Comment.find_by_id(comment_id)
      if comment.user_id!= session[:current_user_id] #not allowing to vote for own question
        @comment_vote = CommentVote.find_by_comment_id_and_user_id(comment_id,session[:current_user_id])
        if @comment_vote==nil
          @comment_vote = CommentVote.new
          @comment_vote.user_id = session[:current_user_id]
          @comment_vote.comment_id = comment_id
          @comment_vote.post_id = comment.post_id
          @comment_vote.save
        else
          flash[:notice]="You can vote only once!!!"
        end
      else
        flash[:notice]="You cannot vote your own comments!!!"
      end
    end
    #respond_to do |format|
      redirect_to(:controller => "posts",:action => "index")
      #format.json { render json: @vote }
    #end
    end
end
