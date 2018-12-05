class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :validate_user, only: [:edit, :update, :destroy]
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def index
    if params[:category].blank?
      @posts = Post.all
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 2)

      @last_post = Post.last

      # Last posts of category "Shoes"
      @shoes_category = Category.find_by(name: "Shoes")
      @shoes_last_post = @shoes_category.posts.last

      # Last posts of category "Glasess"
      @glasses_category = Category.find_by(name: "Glasses")
      @glasses_last_post = @glasses_category.posts.last
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(category_id: @category_id)
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 2)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path, notice: "El post fue creado exitosamente"
    else
      flash[:alert] = "El post fallo en crearse, vuelva a ingresarlo"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "El post fue actualizado exitosamente"
    else
      flash[:alert] = "El post fallo en editarse, vuelva a ingresarlo"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    # flash[:notice] = "El post fue eliminado exitosamente!"

    redirect_to posts_path, notice: "El post fue eliminado exitosamente!"
  end

  private
  # Strong parameters
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :category_id)
    end

    # def validate_user
    #   unless current_user.posts.ids.to_s.include? params[:id]
    #     redirect_to root_path
    #     flash[:alert] = "You don't have permissions"
    #   end
    # end

    def is_admin?
      unless current_user.admin?
        flash[:alert] = "You dont have permissions"
        redirect_to root_path
      end
    end


end