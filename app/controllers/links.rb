Shortener.controllers :links do

  # GET /links/show/:slug
  get :show, :with => :slug do
    @link = Link.find_by_slug! params[:slug]
    render 'links/show'
  end

  # GET /links/new
  get :new do
    render 'links/new'
  end

  # POST /links/create
  post :create do
    @link = Link.new params[:link]
    if @link.save
      redirect url(:links, :show, :slug => @link.slug)
    else
      render 'links/new'
    end
  end
end
