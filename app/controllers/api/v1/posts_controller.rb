class Api::V1::PostsController < ApplicationController
    def index
        @posts = Post.all
        render json: @posts, status: 200
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, status: 200
    end

    def create
        @category = Category.find_by(id: post_params["category_id"])

        @post = Post.new(post_params)
        @post.category = @category

        if @post.save!
            render json: @post, status: 200
        else
            render json: @post.errors, status: :unprocessable_entity
        end
        
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        render json: @post, status: 200
    end

    def destroy
        @post = Post.find(params[:id])
        @post.delete
        render json: {postId: @post.id}
    end

   private

   def post_params
    params.require(:post).permit(:category_id, :date, :content1, :content2, :content3, :likes)
   end
end
