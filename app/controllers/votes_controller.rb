class VotesController < ApplicationController
  # GET /votes/new
  # GET /votes/new.json
  def new
    post_id = params[:post_id]
    if session[:current_user_id]!=nil
      post = Post.find_by_id(post_id)
      if post.user_id!= session[:current_user_id] #not allowing to vote for own question
        @vote = Vote.find_by_post_id_and_user_id(post_id, session[:current_user_id])
        if @vote==nil
          @vote = Vote.new
          @vote.user_id = session[:current_user_id]
          @vote.post_id = post.id
          post.numVotes = post.numVotes+1
          post.save
          @vote.save
        else
          flash[:alert] = "You can vote only once"
          redirect_to(:controller => "posts", :action => "index")
          return
        end
        flash[:notice] =  "Voted Successfully"
        redirect_to(:controller => "posts", :action => "index")
        return
      end
    end
    #respond_to do |format|
    flash[:alert] = "You cannot vote your own question!!!"
    redirect_to(:controller => "posts", :action => "index")
    return
    #format.json { render json: @vote }
    #end
  end
end