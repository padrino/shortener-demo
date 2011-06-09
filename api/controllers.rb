Api.controllers do

  # GET /show.json
  get :show, :provides => [:json] do
    @link = Link.find_by_slug! params[:slug]
    render 'show'
  end

  # POST /create.json
  post :create, :provides => [:json] do
    @link = Link.create :url => params[:url]
    render 'show'
  end
end

