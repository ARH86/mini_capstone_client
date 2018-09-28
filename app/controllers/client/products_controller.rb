class Client::ProductsController < ApplicationController
  def index
    response = HTTP.get("http://localhost:3000/api/products")
    @products = response.parse
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                     name: params[:name],
                     price: params[:price],
                     description: params[:description],
                     supplier_id: params[:supplier_id],
                     image_url: params[:image_url],

    }

    response = HTTP.post(
                         "http://localhost:3000/api/products",
                         form: client_params
                        )

    @products = response.parse
    redirect_to "/client/products/#{@products["id"]}"
  end

  def show
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
    @products = response.parse
    render 'show.html.erb'
  end

  def edit
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
    @products_id = params[:id]
    render 'edit.html.erb'
  end

  def update
      client_params = {
                      name: params[:name],
                     price: params[:price],
                     description: params[:description],
                     supplier_id: params[:supplier_id],
                     image_url: params[:image_url],

      }
    response = HTTP.patch("http://localhost:3000/api/products/#{params[:id]}")
    @products_id = params[:id]
    redirect_to "/client/products/#{ @products["id"] }"
  end

  def destroy
    HTTP.delete("http://localhost:3000/api/products/#{param[:id]}")
    redirect_to "/client/products"
  end
end
