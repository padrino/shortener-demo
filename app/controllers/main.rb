Shortener.controllers :main do

  # GET /
  get :index, :map => '/' do
    render 'main/index'
  end

  # GET /:slug
  get :slug, :map => '/:slug' do
    @link = Link.find_by_slug!(params[:slug])
    redirect @link.url
  end
end
