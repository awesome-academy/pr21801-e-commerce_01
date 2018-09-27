class SearchesController < ApplicationController
  def index
    q = params[:search]
    products = Product.search(name_cont: q).result
    @items = products
    respond_to do |format|
      format.js
      format.html
    end
  end
end
