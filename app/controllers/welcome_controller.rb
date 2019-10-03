class WelcomeController < ApplicationController
  def index
  	@products  = Product.all.paginate(page: params[:page], per_page: 4)

  end
end
