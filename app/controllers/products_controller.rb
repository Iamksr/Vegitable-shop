class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def user_product
    @products = Product.where(user_id: params[:id])
  end
  def current_user_product
    @products = current_user.products.paginate(page: params[:page], per_page: 4)
  end
  # GET /products
  # GET /products.json
  def index
    @events = User.all
    @map_data = @events.map{|e| [ e.email,  e.latitude, e.longitude, e.image,e.name, e.city, e.state, e.id]}
    if params[:id].present?
          @category = Category.find(params[:category_id])
          @products = @cat.products.paginate(page: params[:page], per_page: 4)
    elsif 
      if params[:search].present?
          @products = Product.where("lower(name) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 4)
      end
    else
      @products = Product.all.paginate(page: params[:page], per_page: 4)
    end
    # elsif params[:category_id].present?
      
    #   @products = @cat.products.paginate(page: params[:page], per_page: 4)
    # else
    #   @products = Product.all.paginate(page: params[:page], per_page: 4)
    #   # @products = Product.all.where("start_date <=?  AND end_date >= ?",Date.today,Date.today)
    # end
    # # @products = Product.all
    #  @categories = Category.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
     # @product = Product.find(params[:id])
    # @product = Product.friendly.find(params[:id])
     @product = Product.friendly.find(params[:id])
    cart_ids = @product.cart_items.joins(:cart).where(carts:{is_done:true}).map(&:cart_id)
     @orders = Order.where(cart_id: cart_ids)
     @reviews = @product.rating_reviews.to_a
    @avg_rating = if @reviews.blank?
       0
     else
       @product.rating_reviews.average(:rating).round(2)
     end

  end
  # def all_product
  #   @products = Product.all.paginate(page: params[:page], per_page: 4)
  # end

  def add_wishlist
    @product = Product.friendly.find(params[:product_id])
    if user_signed_in?
      existing_wishlist = current_user.wishlists.where(product_id: @product.id)
      if existing_wishlist.present?
        flash[:notice] = "Product is already into your wishlist"
        redirect_to root_path
      else
        current_user.wishlists.create(product_id: @product.id)
        flash[:notice] = "Product has been added into your wishlist"
        redirect_to root_path
      end
    else
      flash[:notice] = "You need to sign_in or sign_up"
      redirect_to "/users/sign_in"
    end
  end
def add_to_cart
 @product = Product.find(params[:product_id])
    if @product
      if user_signed_in?
        if current_cart.present?
          cart_item = current_cart.cart_items.find_by_product_id(@product.id)
          if cart_item.blank?
            cart_item = current_cart.cart_items.new(product_id: @product.id)
          end
          cart_item.unit_price = @product.price
          cart_item.price = cart_item.unit_price * cart_item.quantity
          # cart_item.price = cart_item.unit_price * 1

          if (cart_item.save)
            flash[:notice] = "Product has been added into your cart"
            redirect_to root_path
          end
        else
        end
      else
        flash[:notice] = "you need to sign in or sign up"
        redirect_to "/users/sign_in"
      end
    end
    def product_detail
      @reviews = @product.rating_reviews.to_a
      @avg_rating = if @reviews.blank?
      0
    else
      @product.rating_reviews.average(:rating).round(2)
    end
  end

  end
   def wishlist
    if current_user.present?
      product_ids = current_user.wishlists.map(&:product_id)
      @products = Product.where(id: product_ids)
    else
      redirect_to new_user_session_path
      # redirect_back fallback_location: root_path
      # product_ids = current_user.wishlists.map(&:product_id)
      # @products = Product.where(id: product_ids)
    end
  end
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end
   def remove_cart
    @product = Product.friendly.find(params[:id])
    @remove_cart = current_cart.cart_items.where(product_id: @product.id).first.destroy
    redirect_to "/cart"
  end
  def remove_wishlist
  
    @product = Product.friendly.find(params[:id])
     @remove_wishlist = current_user.wishlists.where(product_id: @product.id).first.destroy
    redirect_to "/wishlist"
  end
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def cart
    @carts = Cart.all
    @cart_items = current_cart.cart_items
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :category_id, :image, :description, :full_price, :quantity, :user_id)
    end
end
