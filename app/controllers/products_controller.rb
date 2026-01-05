class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @products = Product
                  .includes(
                    :user,
                    images_attachments: :blob
                  )
                  .order(created_at: :desc)
  end

  def my
    @products = current_user.products
                            .includes(images_attachments: :blob)
                            .order(created_at: :desc)
  end

  def show
    # opcional: preload das imagens para a página de detalhe
    @product = Product
                 .includes(images_attachments: :blob)
                 .find(params[:id])
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to @product, notice: "Produto criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Produto atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Produto removido com sucesso."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_user!
    redirect_to products_path, alert: "Acesso não autorizado." unless @product.user == current_user
  end

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :price,
      :condition,
      images: []
    )
  end
end
