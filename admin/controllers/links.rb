Admin.controllers :links do

  get :index do
    @links = Link.all
    render 'links/index'
  end

  get :new do
    @link = Link.new
    render 'links/new'
  end

  post :create do
    @link = Link.new(params[:link])
    if @link.save
      flash[:notice] = 'Link was successfully created.'
      redirect url(:links, :edit, :id => @link.id)
    else
      render 'links/new'
    end
  end

  get :edit, :with => :id do
    @link = Link.find(params[:id])
    render 'links/edit'
  end

  put :update, :with => :id do
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:notice] = 'Link was successfully updated.'
      redirect url(:links, :edit, :id => @link.id)
    else
      render 'links/edit'
    end
  end

  delete :destroy, :with => :id do
    link = Link.find(params[:id]) rescue nil
    if link && link.destroy
      flash[:notice] = 'Link was successfully destroyed.'
    else
      flash[:error] = 'Cannot destroy link!'
    end
    redirect url(:links, :index)
  end
end
