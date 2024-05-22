class CategoryController < ApplicationController
  def index
    categories = Category.all
    render json: { categories: categories }, status: :ok
  end

  def create
  end

  def update
  end

  def delete
  end

  def show
  end
end
