class RatingReviewsController < ApplicationController
  before_action :set_rating_review, only: [:show, :edit, :update, :destroy]

  # GET /rating_reviews

  # GET /rating_reviews.json
  def index
    @ratings = RatingReview.all
  end

  # GET /rating_reviews/1
  # GET /rating_reviews/1.json
  def show
  end

  # GET /rating_reviews/new
  def new
    @product = Product.find(params[:id])
    @rating = RatingReview.new
  end

  # GET /rating_reviews/1/edit
  def edit
  end

  # POST /rating_reviews
  # POST /rating_reviews.json
  def create
  def create
    @product = Product.friendly.unscoped.find(params[:rating_review][:product_id])
    @review_user = RatingReview.where(product_id: @product.id, user_id: params[:rating_review][:user_id])
    if @review_user.present?
        @rating = @review_user.update(rating_params)
          # redirect_to "/order_review"
          redirect_back(fallback_location:  @rating)
          flash[:notice] = "Rating-Review successfully updated"
    else
        @rating = RatingReview.new(rating_params)
        if @rating.save
          redirect_to @rating
          flash[:notice] = "Rating-Review successfully created"
        else
          render 'new' 
        end
    end
  end  
  # PATCH/PUT /rating_reviews/1
  # PATCH/PUT /rating_reviews/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_review_params)
        format.html { redirect_to @rating_review, notice: 'Rating review was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating_review }
      else
        format.html { render :edit }
        format.json { render json: @rating_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rating_reviews/1
  # DELETE /rating_reviews/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to rating_reviews_url, notice: 'Rating review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @rating = RatingReview.friendly.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating_review).permit(:user_id, :product_id, :rating, :review)
    end
end
